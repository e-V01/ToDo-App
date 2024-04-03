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
    
    @EnvironmentObject var iconSettings: IconNames
    
    @State private var showingSettingsView: Bool = false
    @State private var showingAddToDoView: Bool = false
    @State private var animatingButton: Bool = false
    
    @ObservedObject var theme = ThemeSettings()
    var themes: [Theme] = themeData
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(self.todos, id: \.self) { todo in
                        HStack {
                            Text(todo.name ?? "Empty")
                            Spacer()
                            Text(todo.priority ?? "Empty")
                        }
                    }
                    .onDelete(perform: deleteTodo)
                }
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            self.showingSettingsView.toggle()
                        } label: {
                            Image(systemName: "paintbrush")
                        } // Settings button
                        .tint(themes[self.theme.themeSettings].themeColor)
                        .sheet(isPresented: $showingSettingsView) {
                            SettingsView()
                                .environmentObject(self.iconSettings)
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                            .tint(themes[self.theme.themeSettings].themeColor)
                    }
            }
                // NO TODO Items
                if todos.count == 0 {
                    EmptyListView()
                }
            } //ZStack
            .sheet(isPresented: $showingAddToDoView) {
                AddToDoView()
                    .environment(\.managedObjectContext,
                                  self.mOC)
            }
            .overlay(alignment: .bottomTrailing) {
                ZStack {
                    Group {
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68,
                                   height: 68,
                                   alignment: .center)
                        
                        Circle()
                            .fill(themes[self.theme.themeSettings].themeColor)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88,
                                   height: 88,
                                   alignment: .center)
                    }
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animatingButton)
                    
                    
                    Button {
                        self.showingAddToDoView.toggle()
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle()
                                .fill(Color("ColorBase")))
                            .frame(width: 48,
                                   height: 48,
                                   alignment: .center)
                        
                    }
                    .tint(themes[self.theme.themeSettings].themeColor)
                    .onAppear {
                        self.animatingButton.toggle()
                        
                    }
                }
                .padding(.bottom, 15)
                .padding(.trailing, 15)
            } // Overlay
            .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true),
                       value: animatingButton)
        } //NavStack
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            let todo = todos[index]
            mOC.delete(todo)
            
            do {
                try mOC.save()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
