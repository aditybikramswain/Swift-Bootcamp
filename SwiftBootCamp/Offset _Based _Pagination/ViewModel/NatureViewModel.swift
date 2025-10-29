//
//  NatureViewModel.swift
//  SwiftBootCamp
//
//  Created by Apple on 28/10/25.
//

import Foundation
import Combine
import SwiftUI

class NatureViewModel: ObservableObject {
    @Published var didLoadPrevious = false
    @Published var imageData = [NatureModel]()
    @Published var isLoading: Bool = false
    private var page = 1
    var pageLimit = 11
    
    @MainActor
    func loadNextPage() async {
        guard !isLoading else {return}
        isLoading = true
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        let stratId = (page - 1) * pageLimit + 1
        let endId = pageLimit + stratId
        await withTaskGroup(of: NatureModel?.self) { group in
            for Id in stratId ... endId {
                group.addTask { [weak self] in
                    guard let self = self else {return nil}
                    let result = await self.fetchImageGetById(of: Id)
                    return result
                }
            }
            
            for await result in group {
                if let model = result {
                    withAnimation(.default) { [weak self] in
                        self?.imageData.append(model)
                    }
                }
            }
        }
        
        self.page += 1
        self.isLoading = false
    }
    

    func fetchImageGetById(of Id: Int) async -> NatureModel {
        let urlString = "https://loremflickr.com/500/400/nature?lock=\(Id)"
        
        // Handle invalid URL
        guard let url = URL(string: urlString) else {
            let model = ifAnyError(Id: Id, messsage: "Invalid URL", status: false, description: NatureError.invalidURL.localizedDescription)
            return model
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                let error = NatureError.networkError(NSError(domain: "Invalid response", code: -1)).localizedDescription
                let model = ifAnyError(Id: Id, messsage: "Invalid HTTP response", status: false, description: error)
                return model
            }
            
            if let image = UIImage(data: data) {
                return NatureModel(imageId: Id, title: "Natural Image \(Id)", image: image, imageUrl: urlString, status: true, description: "Image fetched successfully")
            } else {
                let error = NatureError.invalidData.localizedDescription
                return ifAnyError(Id: Id, messsage: "Invalid image data", status: false, description: error)
            }
            
        } catch {
            //Handle network error
            let errorDescription = NatureError.networkError(error).localizedDescription
            let model = ifAnyError(Id: Id,messsage: "Network request failed", status: false, description: errorDescription)
            return model
        }
    }

}

extension NatureViewModel {
    func ifAnyError(Id: Int, messsage: String, status: Bool, description: String? = nil) -> NatureModel {
        let urlString = "https://loremflickr.com/500/400/nature?lock=\(Id)"
        let model = NatureModel(imageId: Id, title: "Natural Image\(Id)", imageUrl: urlString, status: status, description: messsage)
        return model
    }
}

