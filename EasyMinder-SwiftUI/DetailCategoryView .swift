//
//  DetailCategoryView.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct DetailCategoryView: View {
    @State private var newItem = ""
    var body: some View {
        NavigationView {
            ZStack {
                Image(systemName: "list.bullet")
                    .foregroundColor(.blue)
                    .font(.system(size: 150))
                    .opacity(0.2)
                ScrollView {
                    VStack {
                        ForEach(0..<20) { row in
                            HStack {
                                Image(systemName: "circle")
                                    .font(.system(size: 23))
                                Spacer()
                                Text("\(row)")
                                Spacer()
                            }
                            
                        }
                        .padding(2)
                        TextField("Add New Reminder", text: $newItem)
                    }
                    
                    .padding()
                }
                .navigationTitle("Category name")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct DetailCategoryView__Previews: PreviewProvider {
    static var previews: some View {
        DetailCategoryView()
    }
}
