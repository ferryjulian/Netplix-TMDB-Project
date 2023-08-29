//
//  UIActivityIndicator+Extensions.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    func stop() {
        self.stopAnimating()
        self.hidesWhenStopped = true
    }
    
    func start() {
        self.startAnimating()
    }
}
