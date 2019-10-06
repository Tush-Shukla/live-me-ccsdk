//
//  UIUtil.swift
//

import Foundation
import UIKit
import Kingfisher

enum  DeviceScreenTypes {
    case SMALL_4_INCH
    case MEDIUM_4_7_INCH
    case LARGE_5_5_INCH
    case IPHONE_X
}

class UIUtil {
    
    class func changeStatusBarColor(style: UIStatusBarStyle) {
        if #available(iOS 9, *) {
            
        } else {
            UIApplication.shared.statusBarStyle = style
        }
    }
    
    class func addBackgroundColorOfStatusBar(rootView: UIView) -> UIView {
        let view = UIView(frame:
            CGRect(x: 0.0, y: -20.0, width: UIScreen.main.bounds.size.width, height: 20.0)
        )
        view.backgroundColor = UIColor(red: 0, green: 121/255, blue: 107/255, alpha: 1) // Primary Dark Color #00796B
        rootView.addSubview(view)
        return view
    }
    
    class func removeBackButtonTitleOfNavigationBar(navigationItem: UINavigationItem) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    class func addActivityIndicator(view: UIView) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.center = view.center
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        return indicator
    }
    
    class func showStatusBarProcessing() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    class func hideStatusBarProcessing() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    class func drawShadow(view: UIView, size: CGSize, color: UIColor, opacity: Float, shadowRadius: CGFloat) {
        view.layer.shadowOffset = size
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = shadowRadius
    
    }
    
    class func removeShadow(view: UIView) {
        view.layer.shadowOffset = CGSize()
        view.layer.shadowColor = UIColor.clear.cgColor
        view.layer.shadowOpacity = 0
        view.layer.shadowRadius = 0
        
    }
    
    class func drawBorder(view: UIView, color: UIColor, thickness: CGFloat) {
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = thickness
    }
    
    class func loadImage(imageView: UIImageView, link: String, showProcessing: Bool) {
        if let url = URL(string: link) {
            if showProcessing {
                imageView.kf.indicator?.startAnimatingView()
            }else {
                imageView.kf.indicator?.stopAnimatingView()
            }
            imageView.kf.setImage(with: url)
        }
    }
    
    class func getDeviceType () -> DeviceScreenTypes {
        if UIScreen.main.bounds.height == 480 || UIScreen.main.bounds.height == 568 {
            return .SMALL_4_INCH
        }else if  UIScreen.main.bounds.height == 667 {
            return .MEDIUM_4_7_INCH
        }else if UIScreen.main.bounds.height == 736 {
            return .LARGE_5_5_INCH
        }
        return .IPHONE_X
    }
    
    class func createGradientLayer (view: UIView, colors: [UIColor]) {
        
        var cgColors:[CGColor] = []
        for color in colors {
            cgColors.append(color.cgColor)
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = cgColors
        view.layer.addSublayer(gradientLayer)
    }
    
    class func scrollToBottomRow(count:Int, tableView: UITableView) {
        if count == 0 { return }
        let lastIndex = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
        tableView.scrollToRow(at: lastIndex, at: .bottom, animated: true)
    }
    
}

