//
//  CCButton.swift
//

import UIKit

@IBDesignable class CCButton: UIButton {
    
    private let BUTTON_FONT = "montana regular"
    
    @IBInspectable var radius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = radius
            self.clipsToBounds = radius > 0
            layer.masksToBounds = radius > 0
        }
    }
    
    @IBInspectable var borderColor: UIColor = .darkGray {
        didSet {
            if borderThickness > 0 {
                UIUtil.drawBorder(view: self, color: borderColor, thickness: borderThickness)
            }
        }
    }
    
    @IBInspectable var borderThickness: CGFloat = 0.0 {
        didSet {
            UIUtil.drawBorder(view: self, color: borderColor, thickness: borderThickness)
        }
    }
        
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
 

}
