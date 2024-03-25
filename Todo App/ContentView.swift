//
//  ContentView.swift
//  Todo App
//
//  Created by Y K on 25.03.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var mOC
    @State private var showingAddToDoView: Bool = false
    
    var body: some View {
        NavigationStack {
            List(0 ..< 5) { item in
            Text("Hella")
            }
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.showingAddToDoView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingAddToDoView) {
                        AddToDoView()
                            .environment(\.managedObjectContext,
                                          self.mOC)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
