//
//  ImagesCarousel.swift
//  stellamc
//
//  Created by Nicolò Pasini on 27/03/21.
//

import SwiftUI
import Combine

struct ImageCarouselView<Content: View>: View {

    private var content: Content
    private var numberOfImages: Int

    @State private var currentIndex: Int = 0

    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }

    var body: some View {
        let dragGesture = DragGesture()
            .onEnded { value in
                if value.translation.width > 50 {
                    swipeLeft()
                } else if value.translation.width < -50 {
                    swipeRight()
                }
            }
        
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    self.content
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                .animation(.spring())
                .gesture(dragGesture)

                HStack(spacing: 3) {
                    ForEach(0..<self.numberOfImages, id: \.self) { index in
                        // Index dots
                        Circle()
                            .frame(width: index == self.currentIndex ? 10 : 8,
                                   height: index == self.currentIndex ? 10 : 8)
                            .foregroundColor(index == self.currentIndex ? Color.backGrey : .white)
                            .overlay(Circle().stroke(Color.frontOrange, lineWidth: 1))
                            .padding(.bottom, 8)
                            .animation(.spring())
                    }
                }
            }
        }
    }

    private func swipeLeft() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }

    private func swipeRight() {
        if currentIndex < numberOfImages - 1 {
            currentIndex += 1
        }
    }
}
