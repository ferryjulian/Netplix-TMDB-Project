//
//  UIButton+Extensions.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import Foundation
import Kingfisher

extension UIButton {
    func setToImage(urlPath: String) {
        if let url = URL(string: urlPath) {
            let modifier = AnyImageModifier { return $0.withRenderingMode(.alwaysOriginal) }
            self.kf.setImage(
                with: url,
                for: .normal,
                options: [.imageModifier(modifier)]
            )
        }
    }
}
