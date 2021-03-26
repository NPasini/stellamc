//
//  DepartmentViewController.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit
import OSLogger
import ReactiveCocoa
import ReactiveSwift

class DepartmentViewController: BaseViewController {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!

    private let messageViewHeight: CGFloat = 40
    private let animationDuration: TimeInterval = 0.3
    private var isNetworkConnectionAvailable: Bool = true
    private(set) var compositeDisposable = CompositeDisposable()

    private let navigationService: NavigationService? = AssemblerWrapper.shared.resolve(NavigationService.self)
    private var networkMonitorService: NetworkMonitorService? = AssemblerWrapper.shared.resolve(NetworkMonitorService.self)

    var departmentViewModel: DepartmentViewModel {
        if viewModel is DepartmentViewModel {
            return viewModel as! DepartmentViewModel
        } else {
            fatalError("The View Model has the wrong type")
        }
    }

    // MARK: - Lyfe Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureNavigationBar()
        setTitle("Products", color: UIColor.frontOrange)
        messageViewHeightConstraint.constant = 0

        compositeDisposable += networkMonitorService?.isNetworkAvailable.producer.startWithValues({ [weak self] (isAvailable: Bool?) in
            if let connectionAvailable = isAvailable {
                self?.isNetworkConnectionAvailable = connectionAvailable
                if !connectionAvailable {
                    self?.showMessageView(message: "Network not available")
                } else {
                    self?.hideMessageView()
                }
            }
        })

        compositeDisposable += departmentViewModel.errorSignal.producer.filter({ !$0.isEmpty }).observe(on: UIScheduler()).on(value: { [weak self] (errorMessage: String) in
            self?.showAlert(title: "Error", message: errorMessage)
        }).start()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        departmentViewModel.getProducts()
    }

    deinit {
        OSLogger.uiLog(message: "Deiniting \(String(describing: DepartmentViewController.self)) and disposing subscriptions")

        if (!compositeDisposable.isDisposed) {
            compositeDisposable.dispose()
        }
    }

    // MARK: - Private Methods

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self

        let spinnerView = UIActivityIndicatorView(style: .large)
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))

        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        spinnerView.startAnimating()
        footerView.addSubview(spinnerView)

        NSLayoutConstraint.activate([
            spinnerView.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: footerView.centerYAnchor)
        ])

        tableView.rowHeight = 150
        tableView.backgroundColor = .clear
        tableView.tableFooterView = footerView
        tableView.register(viewType: DepartmentProductTableViewCell.self)

        compositeDisposable += tableView.reactive.reloadData <~ departmentViewModel.productsDataSource.signal.map({ [weak self] (gazers: [Product]) in
            OSLogger.uiLog(message: "Reloading TableView", access: .public, type: .debug)
            if gazers.count == 0, let isConnectionAvailable = self?.isNetworkConnectionAvailable, isConnectionAvailable {
                DispatchQueue.main.async {
                    self?.showAlert(title: "No Gazers", message: "There are no products for this department")
                }
            }
        })

        compositeDisposable += spinnerView.reactive.isAnimating <~ departmentViewModel.stopFetchingData.producer.map({ [weak self] (stopFetching: Bool) -> Bool in
            OSLogger.uiLog(message: "Spinner view is spinning: \(!stopFetching)", access: .public, type: .debug)

            DispatchQueue.main.async {
                if stopFetching {
                    self?.tableView.tableFooterView = UIView(frame: .zero)
                } else {
                    self?.tableView.tableFooterView = footerView
                }
            }

            return !stopFetching
        })
    }

    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        customizeNavigationBar(backgroundColor: UIColor.backGrey, backButtonColor: UIColor.lightText)
    }

    private func showMessageView(message: String) {
        DispatchQueue.main.async {
            self.messageLabel.text = message
            self.messageViewHeightConstraint.constant = self.messageViewHeight

            UIView.animate(withDuration: self.animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }

    private func hideMessageView() {
        DispatchQueue.main.async {
            self.messageViewHeightConstraint.constant = 0

            UIView.animate(withDuration: self.animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)

        navigationController?.present(alert, animated: true, completion: nil)
    }
}

extension DepartmentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentViewModel.productsDataSource.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = departmentViewModel.productsDataSource.value[indexPath.row]

        if let cell = tableView.dequeueReusableCell(withIdentifier: DepartmentProductTableViewCell.identifier, for: indexPath) as? DepartmentProductTableViewCell {
            cell.configure(with: cellModel)
            cell.accessibilityIdentifier = "DataCell\(indexPath.row)"
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension DepartmentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = PDPViewModel(product: departmentViewModel.productsDataSource.value[indexPath.row])
        navigationService?.push(page: .pdp, with: viewModel, using: navigationController, animated: true)
    }
}

extension DepartmentViewController: UITableViewDataSourcePrefetching {
    private func isLoadingCell(at indexPath: IndexPath) -> Bool {
        return indexPath.row >= (departmentViewModel.productsDataSource.value.count - 1)
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell(at:)) {
            OSLogger.uiLog(message: "Fetching new Star Gazers", access: .public, type: .debug)
            departmentViewModel.getProducts()
        }
    }
}
