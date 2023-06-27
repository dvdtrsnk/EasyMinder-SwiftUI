//
//  SelectIconView.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct SelectIconView: View {
    
    private var itemsOnRow = 6

    @Binding var selectedIcon: Image
    private var icons: [Image]
    private var chunkedIcons: [[Image]] {
        icons.chunked(into: itemsOnRow)
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(height: CGFloat(chunkedIcons.count)*60)
                .foregroundColor(Color(UIColor.systemGroupedBackground))
            
            VStack(spacing: -10) {
                ForEach(chunkedIcons.indices, id: \.self) { index in
                    HStack{
                        ForEach(chunkedIcons[index].indices, id: \.self) { iconIndex in
                            Button {
                                selectedIcon = chunkedIcons[index][iconIndex]
                            } label: {
                                chunkedIcons[index][iconIndex]
                                    .foregroundColor(selectedIcon == chunkedIcons[index][iconIndex] ? Color.gray : Color.white)
                                    .frame(width: 50, height: 50)

                            }
                        }
                    }
                    .padding(5)
                    
                }
                
            }
        }
    }
    
    init(_ icons: [Image], selectedIcon: Binding<Image>) {
        self.icons = icons
        self._selectedIcon = selectedIcon
    }
    
}
