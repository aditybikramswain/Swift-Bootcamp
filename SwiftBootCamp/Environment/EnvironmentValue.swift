//
//  EnvironmentValue.swift
//  SwiftBootCamp
//
//  Created by Apple on 30/10/25.
//

import SwiftUI

struct EnvironmentValue: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text("The current color scheme is \(colorScheme == .dark ? "Dark": "Light")")
            .padding()
            .background(colorScheme == .dark ? Color.black : Color.white)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .cornerRadius(10)
            .shadow(radius: 10)
        
        
    }
}

#Preview {
    EnvironmentValue()
}
import SwiftUI

struct DarkModeShadowExample: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            (colorScheme == .dark ? Color.black : Color.white)
                .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 25)
                .fill(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white)
                .frame(width: 200, height: 200)
                .shadow(color: shadowColor, radius: 15, x: 0, y: 10)
                .overlay(Text("Shadow").foregroundColor(.primary))
        }
    }

    var shadowColor: Color {
        colorScheme == .dark
        ? Color.white.opacity(0.2)  // light glow for dark mode
        : Color.black.opacity(0.3)  // dark shadow for light mode
    }
}

#Preview {
    NeumorphicButton()
}
struct NeumorphicButton: View {
    @Environment(\.colorScheme) var scheme

    var body: some View {
        Circle()
            .fill(scheme == .dark ? Color.gray.opacity(0.25) : Color.white)
            .frame(width: 100, height: 100)
            .shadow(color: scheme == .dark ? Color.white.opacity(0.1) : Color.white.opacity(0.8),
                    radius: 10, x: -5, y: -5)
            .shadow(color: scheme == .dark ? Color.black.opacity(0.6) : Color.gray.opacity(0.4),
                    radius: 10, x: 5, y: 5)
            .overlay(Image(systemName: "moon.fill")
                .foregroundColor(scheme == .dark ? .white : .gray))
    }
}

#Preview {
    ZStack {
        Color(red: 0.1, green: 0.1, blue: 0.12)
            .ignoresSafeArea()
        NeumorphicButton()
    }
}

