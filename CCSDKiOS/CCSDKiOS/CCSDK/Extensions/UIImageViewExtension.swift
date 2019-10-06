//
//  UIImageViewExtension.swift
//

import Foundation
import UIKit

extension UIImageView {
    
    func imageOverlay(color: UIColor) {
        if let image = self.image {
            self.image = image.withRenderingMode(.alwaysTemplate)
            self.tintColor = color
        }
    }
    
    
}
