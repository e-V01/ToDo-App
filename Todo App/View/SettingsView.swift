//
//  SettingsView.swift
//  Todo App
//
//  Created by Y K on 01.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var pM
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION 3
                    Section {
                        FormRowLinkView(icon: "apple.logo",
                                        color: Color.black,
                                        text: "Apple", 
                                        link: "www.apple.com")
                        FormRowLinkView(icon: "link",
                                        color: Color.blue,
                                        text: "Twitter", 
                                        link: "www.x.com")
                        FormRowLinkView(icon: "play.rectangle",
                                        color: Color.red,
                                        text: "Youtube", 
                                        link: "www.youtube.com")
                        
                    } header: {
                        Text("Follow us on social media")
                    }
                    .padding(.vertical, 1)

                    // MARK: - SECTION 4
                    Section {
                        FormRowStaticView(icon: "gear",
                                          firstText: "Application",
                                          secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal",
                                          firstText: "Compatibility",
                                          secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard",
                                          firstText: "Developer",
                                          secondText: "Yuriy K.")
                        FormRowStaticView(icon: "paintbrush",
                                          firstText: "Designer",
                                          secondText: "R. Petras")
                        FormRowStaticView(icon: "flag",
                                          firstText: "Version",
                                          secondText: "1.0.0")
                    } header: {
                        Text("About the application")
                    }

                }
                .listStyle(GroupedListStyle())
                // adds a gray bar above and below List or Form
                .environment(\.horizontalSizeClass, .regular)
                // MARK: - FOOTER
                Text("Made with ❤️")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundStyle(Color.secondary)
            }
            .toolbar() {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        self.pM.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("ColorBackground").ignoresSafeArea(.all))
        }
    }
}

#Preview {
    SettingsView()
}
