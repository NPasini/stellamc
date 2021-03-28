//
//  ProductView.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductView: View {

    @ObservedObject private var viewModel: PDPViewModel

    init(viewModel: PDPViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: true, content: {
            GeometryReader { geometry in
                ImageCarouselView(numberOfImages: self.viewModel.product.pdpImagesURLs.count) {
                    ForEach(self.viewModel.product.pdpImagesURLs, id: \.self) { (imageURL: URL) in
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
                    Text(viewModel.product.name.lowercased().capitalizingFirstLetter())
                        .font(.headline)
                        .foregroundColor(.frontOrange)
                        .lineLimit(nil)
                    Spacer()
                    Text(String(format: "%.2f", round(viewModel.product.price*100)/100) + " €")
                        .font(.headline)
                        .foregroundColor(.backGrey)
                }

                HStack(alignment: .center, spacing: 20, content: {
                    if let macroCategory = viewModel.product.macroCategory {
                        Text(macroCategory.lowercased().capitalizingFirstLetter())
                            .padding(5)
                            .font(.callout)
                            .foregroundColor(.backGrey)
                            .background(Color.frontOrange)
                            .clipShape(Capsule())
                    }

                    if let microCategory = viewModel.product.microCategory {
                        Text(microCategory.lowercased().capitalizingFirstLetter())
                            .padding(5)
                            .font(.callout)
                            .foregroundColor(.backGrey)
                            .background(Color.frontOrange)
                            .clipShape(Capsule())
                    }
                })
                .padding(.top, 15)

                if let sizes = viewModel.product.details?.sizes, sizes.count > 0 {
                    HStack(alignment: .center, spacing: 20, content: {
                        Text("Sizes:")
                            .font(.body)
                            .foregroundColor(.frontOrange)
                        ForEach(sizes, id: \.self) { (size: ProductSize) in
                            Text(size.description)
                                .font(.body)
                                .foregroundColor(.backGrey)
                        }
                        Spacer()
                    })
                }

                if let colors = viewModel.product.details?.colors, colors.count > 0 {
                    HStack(alignment: .center, spacing: 10, content: {
                        Text("Colors:")
                            .font(.body)
                            .foregroundColor(.frontOrange)
                        ForEach(colors, id: \.self) { (color: ProductColor) in
                            Text(color.description)
                                .font(.body)
                                .foregroundColor(.backGrey)
                        }
                        Spacer()
                    })
                    .padding(.vertical, 10)
                }
            }
            .padding(.horizontal, 15)
            .padding([.top, .bottom], 10)
        })
        .background(Color.backLightGrey)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(id: "0943204", productCode: "12", price: 30.5, name: "Jeans with very interesting pattern designed", microCategory: "Jeans blue", macroCategory: "Jeans denim", thumbURLString: URL(string: "https://jdsajdsa.sdadsa"), pdpImagesURLStrings: [])
        let viewModel = PDPViewModel(product: product)
        ProductView(viewModel: viewModel)
    }
}
