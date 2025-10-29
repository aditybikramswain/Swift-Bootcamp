//
//  NatureModel.swift
//  SwiftBootCamp
//
//  Created by Apple on 28/10/25.
//

import Foundation
import UIKit
struct NatureModel: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageId: Int
    var title: String
    var image: UIImage?
    var imageUrl: String
    var status: Bool = false
    var description: String?
}
enum NatureError: LocalizedError {
    case invalidURL
    case invalidData
    case networkError(Error)
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Please check the URL format."
        case .invalidData:
            return "Invalid data received from the server."
        case .networkError(let err):
            return "Network error: \(err.localizedDescription)"
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

