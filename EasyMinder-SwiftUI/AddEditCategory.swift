//
//  AddEditCategory.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct AddEditCategory: View {
    @Environment(\.managedObjectContext) var moc

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
                        save()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(selectedColor)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                    } label: {
                        Text("Save")
                            .foregroundColor(categoryName.isEmpty ? .gray : selectedColor)
                            .font(.headline)
                    }
                    .disabled(categoryName.isEmpty)


                }
                ToolbarItem(placement: .principal) {
                    selectedIcon
                        .foregroundColor(selectedColor)
                }
            }
        }

    }
    
    func save() {
        let newCategory = Category(context: moc)
        newCategory.name = categoryName
        
        dismiss()
    }
}




struct AddEditCategory_Previews: PreviewProvider {
    static var previews: some View {
        AddEditCategory()
    }
}
