//
//  DepartmentCollectionViewCell.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    private(set) var department: Department?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = 20
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLable.text = ""
        imageView.image = nil
    }

    func configure(for department: Department) {
        titleLable.text = department.name
        imageView.image = UIImage(named: department.image)
    }
}

