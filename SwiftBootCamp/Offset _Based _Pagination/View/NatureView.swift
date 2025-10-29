//
//  ContentView.swift
//  SwiftBootCamp
//
//  Created by Apple on 28/10/25.
//

import SwiftUI

struct NatureView: View {
    @StateObject var vm = NatureViewModel()
    let column = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
//        GridItem(.flexible()),
    ]
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: column) {
                    ForEach(vm.imageData.indices, id: \.self) { index in
                        let items = vm.imageData[index]
                        VStack {
                            if let image = items.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .clipped()
                                    .cornerRadius(12)
                            } else {
                               Rectangle()
                                    .fill(Color.gray.opacity(0.5))
                                    .overlay {
                                        Text(items.description ?? "Error")
                                            .font(.caption.bold())
                                            .foregroundColor(.red)
                                            .padding()
                                    }
                                    .frame(height: 150)
                                    .cornerRadius(12)
                            }
                            Text(items.title)
                                .font(.caption)
                           
                        }
                        .onAppear {
                            if index == vm.imageData.count - 1  {
                                Task {
                                     await vm.loadNextPage()
                                }
                            }
                            
                        }
                        
                    }
                }
                if vm.isLoading {
                    ProgressView("Loading More...")
                        .padding()
                }
            }
            .task {
                await vm.loadNextPage()
            }
            .navigationTitle("My page")
            
        }
    }
}

#Preview {
    NatureView()
}
