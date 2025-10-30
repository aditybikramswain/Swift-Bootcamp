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
 
    init() {
        print("Intilized the view model")
    }
    
    func incremnet() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.count += 1
           // self?.incremnet()
            
        }
    }
    
}
