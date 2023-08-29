//
//  UIView+Extensions.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import Foundation
import UIKit
import SnapKit

extension UIView {
    @objc @IBInspectable
    var radiusView: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
}

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

fileprivate var uiView: UIView?

extension UIViewController {
    
    func showSpinner() {
        
        uiView = UIView(frame: self.view.frame)
        uiView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        activity.startAnimating()
        uiView?.addSubview(activity)
        self.view.addSubview(uiView!)
        
        let viewBackgroundLoading: UIView = UIView(frame: self.view.frame)
        viewBackgroundLoading.backgroundColor = .lightGray
        viewBackgroundLoading.alpha = 0.7
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 10
        
        viewBackgroundLoading.addSubview(activity)
        uiView?.addSubview(viewBackgroundLoading)
        activity.startAnimating()
        
        activity.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        viewBackgroundLoading.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.center.equalToSuperview()
        }
        
    }
    
    func hideSpinner() {
        uiView?.removeFromSuperview()
        uiView = nil
    }
}
