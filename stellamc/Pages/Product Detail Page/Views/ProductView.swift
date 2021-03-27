//
//  ProductView.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import SwiftUI

struct ProductView: View {
    var body: some View {
        ScrollView {
            // ImageCarouselView Will Go Here.
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image("swiftTom")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                    
                    VStack(alignment: .leading) {
                        Text("Written By")
                            .foregroundColor(.gray)
                        Text("Thomas Prezioso Jr")
                    }
                }
                
                Text("Feb 10 2020")
                    .foregroundColor(.gray)
                
                Text("How to Make a Image Carousel in SwiftUI")
                    .bold()
                
                Text("lorem ipsum sic dolor")
                    .lineLimit(nil)
            }
            .padding(.horizontal)
            .padding(.top, 16.0)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
