//
//  ImageDownloader.swift
//  CarStonks
//
//  Created by Amit on 19/02/2024.
//

import Foundation
import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    private let urlSession = URLSession(configuration: .default)
    
    init() {}
    
    func downloadImage(from url: URL) async -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = urlSession.configuration.urlCache?.cachedResponse(for: request),
           let image = UIImage(data: cachedResponse.data) {
//            debugPrint("Image fetched from cache")
            return image
        }
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            urlSession.configuration.urlCache?.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
//            debugPrint("Image downloaded from URL")
            return UIImage(data: data)
        } catch {
            debugPrint("Failed to download image:", error.localizedDescription)
            return nil
        }
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
