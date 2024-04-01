//
//  FormRowLinkView.swift
//  Todo App
//
//  Created by Y K on 01.04.2024.
//

import SwiftUI

struct FormRowLinkView: View {
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundStyle(Color.white)
                
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text)
                .foregroundStyle(Color.gray)
            Spacer()
            Button {
                // opens link
                guard let url = URL(string:  self.link),
                      UIApplication.shared.canOpenURL(url) else {
                    return
                }
                UIApplication.shared.open(url as URL)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, 
                                  weight: .semibold,
                                  design: .rounded))
            }
            .tint(Color(.systemGray2))
        }
    }
}

#Preview {
    FormRowLinkView(icon: "apple.logo",
                    color: Color.pink,
                    text: "Website",
                    link: "www.apple.com")
}
