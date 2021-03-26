//
//  DepartmentCollectionViewCell.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLable: UILabel!

    private(set) var department: Department?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = 20
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLable.text = ""
    }

    func configure(for department: Department) {
        titleLable.text = department.name
    }
}

