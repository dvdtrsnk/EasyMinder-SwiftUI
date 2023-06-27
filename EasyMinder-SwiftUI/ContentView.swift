//
//  ContentView.swift
//  EasyMinder-SwiftUI
//
//  Created by David Třešňák on 27.06.2023.
//

import SwiftUI

struct ContentView: View {
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
                    List(0..<20) {
                        Text("row \($0)")
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
                AddEditCategory()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
