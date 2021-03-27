//
//  ProductView.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductView: View {

    private var product: Product

    init(product: Product) {
        self.product = product
    }

    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ImageCarouselView(numberOfImages: self.product.pdpImagesURLs.count) {
                    ForEach(self.product.pdpImagesURLs, id: \.self) { (imageURL: URL) in
                        WebImage(url: imageURL)
                            .resizable()
                            .scaledToFill()
                            .transition(.fade(duration: 0.5))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                    }
                }
            }.frame(height: 500, alignment: .center)
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(product.name.lowercased().capitalizingFirstLetter())
                        .font(.headline)
                        .foregroundColor(.frontOrange)
                        .lineLimit(nil)
                    Spacer()
                    Text(String(format: "%.2f", round(product.price*100)/100) + " €")
                        .font(.headline)
                        .foregroundColor(.backGrey)
                }

                HStack(alignment: .center, spacing: 20, content: {
                    if let macroCategory = product.macroCategory {
                        Text(macroCategory.lowercased().capitalizingFirstLetter())
                            .padding(5)
                            .font(.callout)
                            .foregroundColor(.backGrey)
                            .background(Color.frontOrange)
                            .clipShape(Capsule())
                    }

                    if let microCategory = product.microCategory {
                        Text(microCategory.lowercased().capitalizingFirstLetter())
                            .padding(5)
                            .font(.callout)
                            .foregroundColor(.backGrey)
                            .background(Color.frontOrange)
                            .clipShape(Capsule())
                    }
                })
                .padding(.top, 15)
            }
            .padding(.horizontal, 15)
            .padding([.top, .bottom], 10)
        }
        .background(Color.backLightGrey)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: "0943204", price: 30.5, name: "Jeans with very interesting pattern designed", microCategory: "Jeans blue", macroCategory: "Jeans denim", thumbURLString: URL(string: "https://jdsajdsa.sdadsa"), pdpImagesURLStrings: [])
        ProductView(product: product)
    }
}
