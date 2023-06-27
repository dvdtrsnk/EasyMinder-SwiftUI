//
//  ContentView.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) var categories: FetchedResults<Category>

    
    @State private var showingSettings = false
    @State private var showingAddEditCategory = false
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    List(0..<3) {
                        Text("row \($0)")
                    }
                    .listRowSeparator(.hidden)
                }
                
                Section("MY LISTS") {
                    List {
                        ForEach(categories, id: \.id) { category in
                            NavigationLink {
                                DetailCategoryView()
                            } label: {
                                HStack {
                                    category.wrappedIcon
                                        .foregroundColor(category.wrappedColor)
                                    Text(category.name!)
                                }
                            }
                        }
                        .onDelete(perform: deleteCategory)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("EasyMinder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddEditCategory = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .sheet(isPresented: $showingAddEditCategory) {
                AddEditCategoryView()
            }
            .onAppear {
                var myColor: Color = .red
                var myStringColor = myColor.toRGBString()
                var colorAsColor = Color.fromRGBString(myStringColor)
                print("\(myStringColor), a zpět \(colorAsColor)")
            }
        }
    }
    
    func deleteCategory(at offsets: IndexSet) {
        for offset in offsets {
            let category = categories[offset]
            moc.delete(category)
        }
        try? moc.save()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
