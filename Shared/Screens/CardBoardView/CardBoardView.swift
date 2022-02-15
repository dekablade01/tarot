//
//  CardBoardView.swift
//  tarot
//
//  Created by Issarapong Poesua on 15/2/22.
//

import SwiftUI

struct CardBoardView: View {
    
    @ObservedObject private var viewModel = ViewModel(tarots: Tarot.allCases)
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("hello")
    }
    
}
