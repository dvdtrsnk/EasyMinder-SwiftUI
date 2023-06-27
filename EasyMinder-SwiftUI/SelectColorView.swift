//
//  SelectColorView.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct SelectColorView: View {
    
    private var itemsOnRow = 6

    @Binding var selectedColor: Color
    private var colors: [Color]
    private var chunkedColors: [[Color]] {
        colors.chunked(into: itemsOnRow)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: CGFloat(chunkedColors.count)*60)
                .foregroundColor(Color(UIColor.systemGroupedBackground))
            
            VStack(spacing: 0) {
                ForEach(chunkedColors.indices, id: \.self) { index in
                    HStack {
                        ForEach(chunkedColors[index], id: \.self) { color in
                            Spacer()
                            Button {
                                selectedColor = color
                            } label: {
                                Circle()
                                    .fill(color)
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedColor == color ? Color.white: Color.clear, lineWidth: 2)
                                    )
                            }
                            Spacer()
                        }
                    }
                    .padding(10)
                    
                }
                
            }
        }
    }
    
    init(_ colors: [Color], selectedColor: Binding<Color>) {
        self.colors = colors
        self._selectedColor = selectedColor
    }
    
}





