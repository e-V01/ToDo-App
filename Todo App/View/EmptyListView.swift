//
//  EmptyListView.swift
//  Todo App
//
//  Created by Y K on 26.03.2024.
//

import SwiftUI

struct EmptyListView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                Image("illustration-no1")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360, alignment: .center)
                    .layoutPriority(1)
                
                Text("Use your time wisely")
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            }
            .padding(.horizontal)
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity)
        .background(Color("ColorBase"))
        .ignoresSafeArea(.all)
    }
}

#Preview {
    EmptyListView()
        .environment(\.colorScheme, .dark)
}
