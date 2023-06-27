//
//  AddEditCategory.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct AddEditCategory: View {
    @Environment(\.dismiss) var dismiss
    @State private var categoryName = ""
    
    @State private var selectedColor: Color = .red
    @State private var selectedIcon: Image = Image(systemName: "person.fill")
    private let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink, .gray, .black, .white, .brown, .teal]
    private let icons: [Image] = [Image(systemName: "book.fill"), Image(systemName: "cart.fill"), Image(systemName: "heart.fill"), Image(systemName: "person.fill"), Image(systemName: "airplane"), Image(systemName: "film.fill"), Image(systemName: "flag.fill"), Image(systemName: "star.fill"), Image(systemName: "gamecontroller.fill"), Image(systemName: "cloud.fill"), Image(systemName: "bolt.fill"), Image(systemName: "camera.fill"), Image(systemName: "bell.fill"), Image(systemName: "gift.fill"), Image(systemName: "magnifyingglass.circle.fill"), Image(systemName: "mic.fill"), Image(systemName: "paintbrush.fill"), Image(systemName: "sun.max.fill")]

   
    var body: some View {
        NavigationView {
            
            VStack {
                TextField("Category Name", text: $categoryName)
                    .multilineTextAlignment(.center)
                    .frame(height: 60)
                    .padding(.horizontal, 30)
                    .padding(.top, 1)
                
                
                
                SelectColorView(colors, selectedColor: $selectedColor)
                    .padding()
                SelectIconView(icons, selectedIcon: $selectedIcon)
                    .padding(.horizontal)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(selectedColor)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        
                    } label: {
                        Text("Save")
                            .foregroundColor(selectedColor)
                            .font(.headline)
                    }
                }
                ToolbarItem(placement: .principal) {
                    selectedIcon
                        .foregroundColor(selectedColor)
                }
            }
        }

    }
    
    func roundedRectangleSection(colors: [Color]) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color(.systemGray6))
            
            HStack {
                ForEach(colors, id: \.self) { color in
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




struct AddEditCategory_Previews: PreviewProvider {
    static var previews: some View {
        AddEditCategory()
    }
}
