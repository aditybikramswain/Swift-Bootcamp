//
//  ContentView.swift
//  SwiftBootCamp
//
//  Created by Apple on 28/10/25.
//

import SwiftUI

struct NatureView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    NatureView()
}
