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
    @State private var onDragLocation: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
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
                        .offset(onDragLocation.size)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    print(value)
                                    withAnimation(.easeInOut) { onDragLocation = value.location }
                                }
                                .onEnded { value in
                                    onDragLocation = .zero
                                    viewModel.updateLocation(of: viewModel.pickCard(), location: value.location)
                                }
                        )
                    
                    
                    ForEach(viewModel.openedCardsWithLocations, id: \.card.tarot.rawValue) { item in
                        Image(item.card.tarot.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .rotationEffect(.radians(item.card.direction.radians))
                            .frame(width: cardWidth, height: cardWidth / Tarot.sizeRatio)
                            .offset(item.location)
                            .gesture(
                            DragGesture()
                                .onChanged { value in
                                    
                                }
                                .onEnded {
                                    
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
