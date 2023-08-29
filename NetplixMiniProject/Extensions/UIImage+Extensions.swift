//
//  UIImage+Extensions.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import Foundation
import Kingfisher

public extension UIImageView {
    func setImageUrl(urlPath: String){
        if let url = URL(string: urlPath) {
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url
            )
        }
    }
}
