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
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    @State private var showingAddToDoView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.todos, id: \.self) { todo in
                    HStack {
                        Text(todo.name ?? "Empty")
                        Spacer()
                        Text(todo.priority ?? "Empty")
                    }
                }
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
