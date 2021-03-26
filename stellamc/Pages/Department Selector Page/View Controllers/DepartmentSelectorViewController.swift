//
//  DepartmentSelectorViewController.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit

class DepartmentSelectorViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    private let navigationService: NavigationService? = AssemblerWrapper.shared.resolve(NavigationService.self)

    var departmentSelectorViewModel: DepartmentSelectorViewModel {
        if viewModel is DepartmentSelectorViewModel {
            return viewModel as! DepartmentSelectorViewModel
        } else {
            fatalError("The View Model has the wrong type")
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: - Private Methods

    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(viewType: DepartmentCollectionViewCell.self)

        let contentInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        collectionView.contentInset = contentInsets
    }

    private func navigateToDepartmentPage(_ department: Department) {
        let departmentViewModel: ViewModel? = nil
        navigationService?.push(page: .department, with: departmentViewModel, using: navigationController, animated: true)
    }
}

extension DepartmentSelectorViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? departmentSelectorViewModel.departments.count : 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DepartmentCollectionViewCell.identifier, for: indexPath) as? DepartmentCollectionViewCell {
            cell.configure(for: departmentSelectorViewModel.departments[indexPath.row])
            cell.accessibilityIdentifier = "DataCell\(indexPath.row)"
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}

extension DepartmentSelectorViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellHeight: CGFloat = 150
        var cellSpacing: CGFloat = 0
        let screenWidth = UIScreen.main.bounds.width
        let horizontalCollectionInsets: CGFloat = collectionView.contentInset.left + collectionView.contentInset.left

        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            cellSpacing = layout.minimumInteritemSpacing
        }

        let cellWidth: CGFloat = (screenWidth - horizontalCollectionInsets - cellSpacing)/2

        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension DepartmentSelectorViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDepartment = departmentSelectorViewModel.departments[indexPath.row]
        navigateToDepartmentPage(selectedDepartment)
    }
}

