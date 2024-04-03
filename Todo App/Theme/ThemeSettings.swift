//
//  ThemeSettings.swift
//  Todo App
//
//  Created by Y K on 03.04.2024.
//

import Foundation

class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
}
