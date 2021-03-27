//
//  DepartmentProductTableViewCell.swift
//  stellamc
//
//  Created by Nicolò Pasini on 26/03/21.
//

import UIKit
import SDWebImage

class DepartmentProductTableViewCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        price.textColor = UIColor.lightText
        productImage.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }

    override func prepareForReuse() {
        price.text = ""
        productName.text = ""
        productImage.image = nil
    }

    func configure(with product: Product) {
        productName.text = product.name.lowercased().capitalizingFirstLetter()
        price.text = String(format: "%.2f", round(product.price*100)/100) + " €"

        if let imageURL = product.thumbURLString {
            productImage.sd_setImage(with: imageURL) { [weak self] (image: UIImage?, error: Error?, cacheType: SDImageCacheType, imageURL: URL?) in
                guard error == nil else { return }

                self?.productImage.image = image
            }
        } else {
            productImage.image = UIImage()
        }
    }
}
