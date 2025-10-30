//
//  EnvironmentObjectPratice.swift
//  SwiftBootCamp
//
//  Created by Apple on 30/10/25.
//

import SwiftUI
import Combine

class UserData: ObservableObject {
    @Published var name: String = "Aditya"
    @Published var score: Int = 0
}
struct EnvironmentObjectPratice: View {
    @StateObject private var userData = UserData()
    var body: some View {
        NavigationStack {
            NavigationLink("FirstViewEnvironmentObjectPratice") {
                FirstViewEnvironmentObjectPratice()
            }
        }
        .environmentObject(userData)
    }
}

struct FirstViewEnvironmentObjectPratice: View {
    @EnvironmentObject var userData: UserData
    var body: some View {
        VStack {
            Text("Helo\(userData.name)")
                .font(.headline)
            Text("Score: \(userData.score)")
            
            NavigationLink("SecondViewEnvironmentObjectPratice") {
                SecondViewEnvironmentObjectPratice()
            }
        }
    }
}

struct SecondViewEnvironmentObjectPratice: View {
    @EnvironmentObject var userData: UserData
    @State private var nameChnage: String = ""
    var body: some View {
        VStack {
            Text("User Name: \(userData.name)")
                .font(.title)
            Text("Score: \(userData.score)")
            
            TextField("Name: ", text: $nameChnage)
                .frame(maxWidth: .infinity)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 1)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green.opacity(0.3))
                        }
                    
                }
            Button("Name Chnge") {
                if !nameChnage.isEmpty {
                    self.userData.name = nameChnage
                }
            }
            
            
        }
    }
}
struct ThirdViewEnvironmentObjectPratice: View {
    var body: some View {
        
    }
}
#Preview {
    EnvironmentObjectPratice()
}
