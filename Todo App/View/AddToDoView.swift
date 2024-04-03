//
//  AddToDoView.swift
//  Todo App
//
//  Created by Y K on 25.03.2024.
//

import SwiftUI
import CoreData

struct AddToDoView: View {
    
    @Environment(\.managedObjectContext) var mOC
    @Environment(\.presentationMode) var pm
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = [
    "High",
    "Normal",
    "Low"
    ]
    
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    @ObservedObject var theme = ThemeSettings.shared
    var themes: [Theme] = themeData
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Hella", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 9))
                        .font(.system(size: 24,
                                      weight: .bold,
                                      design: .default))
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Button {
                        if self.name !=  "" {
                            let todo = Todo(context: self.mOC)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do {
                                try self.mOC.save()
//                                print("new todo: \(todo.name ?? ""), Priority: \(todo.priority ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Please, enter something)"
                            return
                        }
                        self.pm.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .font(.system(size: 24, 
                                          weight: .bold,
                                          design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(themes[self.theme.themeSettings].themeColor)
                            .clipShape(RoundedRectangle(cornerRadius: 9))
                            .foregroundStyle(Color.white)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 30)
                Spacer()
            }
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.pm.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), 
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
        .tint(themes[self.theme.themeSettings].themeColor)
    }
}

#Preview {
    AddToDoView()
}
