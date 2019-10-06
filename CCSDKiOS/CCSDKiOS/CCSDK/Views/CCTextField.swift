//
//  CCTextField.swift
//

import Foundation
import UIKit

@IBDesignable class CCTextField: UITextField {
    
    @IBInspectable var radius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = radius
            layer.borderColor = UIColor.clear.cgColor
        }
    }
    @IBInspectable var yPadding: CGFloat = 0.0
    @IBInspectable var xPadding: CGFloat = 0.0
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {        
        return bounds.insetBy(dx: xPadding, dy: yPadding)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: xPadding, dy: yPadding)
    }
    
    
}
