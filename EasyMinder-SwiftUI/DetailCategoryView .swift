//
//  DetailCategoryView.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct DetailCategoryView: View {
    
    @Environment(\.managedObjectContext) var moc
        @FetchRequest var items: FetchedResults<Item>
    
    
    @State private var newItemName = ""
    private var category: Category?
    private let categoryTitle: String
    private let categoryIcon: Image
    private let categoryColor: Color
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView {
                        VStack {
                            ForEach(items, id: \.id) { item in
                                HStack {
                                    Image(systemName: item.isDone ? "circle.fill" : "circle")
                                        .foregroundColor(item.parentCategory?.wrappedColor)
                                        .font(.system(size: 23))
                                        .onTapGesture {
                                            item.isDone.toggle()
                                        }
                                    
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
                
                categoryIcon
                    .font(.system(size: 150))
                    .foregroundColor(categoryColor)
                    .opacity(0.2)
                
            }
            
        }
        .navigationTitle(categoryTitle)
    }
    
    init(_ predicate: NSPredicate,_ category: Category? = nil, title: String, icon: Image, color: Color) {
        self.categoryColor = color
        self.categoryIcon = icon
        self.categoryTitle = title
        self.category = category
        _items = FetchRequest<Item>(sortDescriptors: [], predicate: predicate)
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
            category!.addToItems(newItem)
            
            try? moc.save()
        }
    }
}

//struct DetailCategoryView__Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCategoryView()
//    }
//}
