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
    
    private let filterOptions: [(name: String, color: Color, icon: Image, predicate: NSPredicate, id: UUID)] = [
        (name: "All Tasks", color: Color(.blue), icon: Image(systemName: "mail.stack"), predicate: NSPredicate(value: true), id: UUID()),
        (name: "Today", color: Color(.red), icon: Image(systemName: "clock.badge.exclamationmark"), predicate: NSPredicate(value: true), id: UUID()),
        (name: "Scheduled", color: Color(.green), icon: Image(systemName: "calendar"), predicate: NSPredicate(value: true), id: UUID())
        ]
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    List {
                        ForEach(filterOptions, id: \.id) { filter in
                            NavigationLink {
                                DetailCategoryView(filter.predicate, title: filter.name, icon: filter.icon, color: filter.color)
                            } label: {
                                HStack {
                                    filter.icon
                                        .foregroundColor(filter.color)
                                    Text(filter.name)
                                }
                            }
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                
                Section("MY LISTS") {
                    List {
                        ForEach(categories, id: \.id) { category in
                            NavigationLink {
                                DetailCategoryView(NSPredicate(format: "parentCategory == %@", category), category, title: category.wrappedName, icon: category.wrappedIcon, color: category.wrappedColor)
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
