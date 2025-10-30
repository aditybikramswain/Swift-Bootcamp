//
//  StateObjectVsObservedObject.swift
//  SwiftBootCamp
//
//  Created by Apple on 30/10/25.
//

import SwiftUI
import Combine
struct StateObjectVsObservedObject: View {
    @State private var count: Int = 0
    var body: some View {
        NavigationStack {
            VStack {
                Text("Count: \(count)")
                    .font(.headline)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .foregroundColor(.white)
                    .background(
                        Capsule()
                            .fill(Color.blue.gradient)
                    )
                    .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
                
                Button {
                    count = Array(1...100).randomElement()!
                } label: {
                    Text("Increment")
                        .font(.headline)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 2)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.blue.opacity(0.1))
                                )
                        )
                        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
                }
                
            }
            VStack {
                NavigationLink("Seccond") {
                    SecondView()
                }
            }
            .padding()
        }
    }
}

struct StateObjectSubView: View {
    @StateObject private var vm = ViewModelCounter()
    var body: some View  {
        VStack {
            Text("Increment: \(vm.count)")
                .padding()
                .padding(.horizontal, 20)
                .background(
                    Capsule()
                        .fill(Color.blue.opacity(0.2))
                )
            Button {
                vm.incremnet()
            } label: {
                Text("Tapped Count button")
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue, lineWidth: 2)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.1))
                            )
                        
                    )
            }

                
            
        }
    }
}
struct SecondView: View {
    var body: some View {
        VStack {
            StateObjectSubView()
                .padding(.vertical)
        }
        NavigationLink("Second View is the") {
            ThirdView()
        }
       
        
        
    }
}

struct ThirdView: View {
    var body: some View {
        Text("Second View is the")
    }
}
#Preview {
    StateObjectVsObservedObject()
}
