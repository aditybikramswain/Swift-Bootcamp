//
//  ViewModelCounter.swift
//  SwiftBootCamp
//
//  Created by Apple on 30/10/25.
//

import Foundation
import Combine
class ViewModelCounter: ObservableObject {
    @Published var count = 0
    @MainActor
    func incremnet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            self?.count += 1
        }
    }
    
}
