//
//  FormRowStaticView.swift
//  Todo App
//
//  Created by Y K on 01.04.2024.
//

import SwiftUI

struct FormRowStaticView: View {
    var icon: String
    var firstText: String
    var secondText: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            Text(firstText)
                .foregroundStyle(Color.gray)
            Spacer()
            Text(secondText)
        }
    }
}

#Preview {
    FormRowStaticView(icon: "gear", firstText: "App", secondText: "Todo")
        .previewLayout(.fixed(width: 375, height: 60))
        .padding()
}
