//
//  UIImageViewExtension.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import UIKit
import SVGKit
import Promises

extension UIImageView {
    func downloadedsvg(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit, withPlaceHolder: UIImage? = nil) {
        contentMode = mode
        self.image = withPlaceHolder
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let receivedicon: SVGKImage = SVGKImage(data: data),
                let image = receivedicon.uiImage
            else {
                return
                
            }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}
