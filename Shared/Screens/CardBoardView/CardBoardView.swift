//
//  CardBoardView.swift
//  tarot
//
//  Created by Issarapong Poesua on 15/2/22.
//

import SwiftUI

extension CGSize {
     
    var point: CGPoint { CGPoint(x: width, y: height) }
}

extension CGPoint {
    
    var size: CGSize { CGSize(width: x, height: y) }
}

struct CardBoardView: View {
    
    @ObservedObject private var viewModel: ViewModel
    @State private var onDragLocationForUnopened: CGPoint = .zero
    @State private var onDragLocationForOpened: CGPoint = .zero
    @State private var draggingItem: Card?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width * CGFloat(0.1)
            ZStack {
                ZStack {
                    Image(Tarot.back)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: cardWidth, height: cardWidth / Tarot.sizeRatio)
                        
                    Image(Tarot.back)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: cardWidth, height: cardWidth / Tarot.sizeRatio)
                        .offset(onDragLocationForUnopened.size)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    withAnimation(.easeInOut) {
                                        onDragLocationForUnopened = value.location
                                    }
                                }
                                .onEnded { value in
                                    onDragLocationForUnopened = .zero
                                    viewModel.updateLocation(of: viewModel.pickCard(), location: value.location.size)
                                }
                        )
                        .onTapGesture(count: 2) {
                            withAnimation { viewModel.reset() }
                        }
                    ForEach(viewModel.openedCardsWithLocations, id: \.card.tarot.rawValue) { item in
                        Image(item.card.tarot.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .rotationEffect(.radians(item.card.direction.radians))
                            .frame(width: cardWidth, height: cardWidth / Tarot.sizeRatio)
                            .offset(draggingItem == item.card ? onDragLocationForOpened.size : item.location)
                            .gesture(
                            DragGesture()
                                .onChanged { value in
                                    draggingItem = item.card
                                    onDragLocationForOpened = value.location
                                }
                                .onEnded { value in
                                    onDragLocationForOpened = .zero
                                    viewModel.updateLocation(of: item.card, location: value.location.size)
                                    draggingItem = nil
                                    
                                }
                            )
                    }
                }
                .offset(CGSize(width: geometry.size.width - (cardWidth + 20), height: geometry.size.height - (cardWidth / Tarot.sizeRatio)))
            }
        }
        .preferredColorScheme(.dark)
    }
    
}
struct CardBoardView_Preview: PreviewProvider {

    static var previews: some View {
        CardBoardView(viewModel: .init(tarots: Tarot.allCases))
            .previewInterfaceOrientation(.landscapeLeft)
            .preferredColorScheme(.dark)
    }
    
}
