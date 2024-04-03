//
//  SettingsView.swift
//  Todo App
//
//  Created by Y K on 01.04.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var pM
    @EnvironmentObject var iconSettings: IconNames
    
    let themes: [Theme] = themeData
    @ObservedObject var theme = ThemeSettings()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION 1
                    Section {
                        Picker(selection: $iconSettings.currentIndex) {
                            ForEach(0..<iconSettings.iconNames.count, id: \.self) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    Spacer()
                                        .frame(width: 8)
                                    
                                    Text(self.iconSettings.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                }
                                
                                .padding(3)
                            }
                        } label: {
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(Color.primary, lineWidth: 2)
                                    Image(systemName: "paintbrush")
                                        .font(.system(size: 28, weight: .regular, design: .default))
                                    .foregroundStyle(Color.primary)
                                }
                                .frame(width: 44, height: 44)
                                
                                Text("App Icons".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color.primary)
                            }
                        }
                        .onReceive([self.iconSettings.currentIndex].publisher.first(), perform: { (value) in
                            let index = self.iconSettings.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value {
                                UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Success! You have changed the app icon.")
                                    }
                                }
                            }
                        })
                        .pickerStyle(.navigationLink)
                    } header: {
                        Text("Choose the app icon")
                    }
                    .padding(.vertical, 3)

                    // MARK: - SECTION 2
                    Section {
                        List {
                            ForEach(themes, id: \.id) { item in
                                Button {
                                    self.theme.themeSettings = item.id
                                    UserDefaults.standard.set(self.theme, forKey: "Theme")
                                } label: {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundStyle(item.themeColor)
                                        
                                        Text(item.themeName)
                                    } // HStack
                                } // Button
                                .tint(Color.primary)
                            } // ForEach
                        } // List
                    } header: {
                        HStack {
                            Text("Choose the App theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(themes[self.theme.themeSettings].themeColor)
                        }
                    } // Section 2
                    .padding(.vertical, 3)

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
        .tint(themes[self.theme.themeSettings].themeColor)
    }
}

#Preview {
    SettingsView()
        .environmentObject(IconNames())
}
