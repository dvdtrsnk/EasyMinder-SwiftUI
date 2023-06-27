//
//  DetailCategoryView.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct DetailCategoryView: View {
    @Environment(\.managedObjectContext) var moc
    
    
    @State private var newItemName = ""
    @State private var category: Category
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack {
                        ForEach(category.wrappedItems, id: \.id) { item in
                            HStack {
                                Image(systemName: item.isDone ? "circle.fill" : "circle")
                                    .font(.system(size: 23))
                                
                                Text("\(item.wrappedName)")
                                Spacer()
                                Image(systemName: "info")
                            }
                            
                        }
                        .padding(2)
                    }
                    
                    .padding()
                }
                ZStack {
                    Color(UIColor.systemBackground)
                        .frame(height: 40)
                    HStack {
                        TextField("Add New Reminder", text: $newItemName)
                        Button {
                            saveNewItem()
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                        }
                    }
                    .padding(.horizontal)


                }
                
            }
            

        }
        .navigationTitle("Category name")

    }
    
    init(_ category: Category) {
        self.category = category
    }
    
    func saveNewItem() {
        if newItemName == "" {
            
        } else {
            let newItem = Item(context: moc)
            newItem.name = newItemName
            newItem.dateCreated = Date.now
            newItem.id = UUID()
            newItem.notification = false
            newItem.parentCategory = category
            newItem.isDone = false
            category.addToItems(newItem)
            
            try? moc.save()
        }
    }
}

//struct DetailCategoryView__Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCategoryView()
//    }
//}
