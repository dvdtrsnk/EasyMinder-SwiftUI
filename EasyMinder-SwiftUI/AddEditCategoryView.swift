//
//  AddEditCategoryView.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct AddEditCategoryView: View {
    @Environment(\.managedObjectContext) var moc

    @Environment(\.dismiss) var dismiss
    @State private var categoryName = ""
    
    @State private var selectedColor: Color = .red
    @State private var selectedIcon: String = "book"
    private let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink, .gray, .black, .white, .brown, .teal]
    private let icons: [String] = ["book.fill", "cart.fill", "heart.fill", "person.fill", "airplane", "film.fill", "flag.fill", "star.fill", "gamecontroller.fill", "cloud.fill", "bolt.fill", "camera.fill", "bell.fill", "gift.fill", "magnifyingglass.circle.fill", "mic.fill", "paintbrush.fill", "sun.max.fill"]

   
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
                        save()
                    } label: {
                        Text("Save")
                            .foregroundColor(categoryName.isEmpty ? .gray : selectedColor)
                            .font(.headline)
                    }
                    .disabled(categoryName.isEmpty)


                }
                ToolbarItem(placement: .principal) {
                    Image(systemName: selectedIcon)
                        .foregroundColor(selectedColor)
                }
            }
        }

    }
    
    func save() {
        let newCategory = Category(context: moc)
        newCategory.name = categoryName
        newCategory.icon = selectedIcon
        newCategory.color = selectedColor.toRGBString()
        newCategory.dateCreated = Date.now
        newCategory.id = UUID()
        
                
        try? moc.save()
        
        dismiss()
    }
}




struct AddEditCategory_Previews: PreviewProvider {
    static var previews: some View {
        AddEditCategoryView()
    }
}




extension Image {

    var sfSymbolName: String? {
        guard let strSeq = "\(String(describing: self))".split(separator: ")").first else { return nil }
        let str = String(strSeq)
        guard let name = str.split(separator: ":").last else { return nil }
        return String(name)
    }
}
