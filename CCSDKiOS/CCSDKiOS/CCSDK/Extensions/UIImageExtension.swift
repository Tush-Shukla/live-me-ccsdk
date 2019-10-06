//
//  UIImageExtension.swift
//

import Foundation
import UIKit

extension UIImage {
    var base64Encoded: String? {
        return self.getJPEGData?.base64EncodedString()
    }
    
    var base64EncodedCompressed: String? {
        return self.jpegData(compressionQuality: 0.5)?.base64EncodedString()
    }
    
    var getCompressedData: Data? {
        return self.jpegData(compressionQuality: 0.5)
    }
    
    var getJPEGData: Data? {
        return self.jpegData(compressionQuality: 1.0)
    }
    
    var getPNGData: Data? {
        return self.pngData()
    }
    
    var sizeInKB: Double {
        if let data = self.jpegData(compressionQuality: 0.0) {
            let sizeInBytes = data.count
            return Double(sizeInBytes) / 1024.0
        }
        return 0
    }
    
    var sizeInMB: Double {
        return sizeInKB / 1024.0
    }
    
    //    func resizeToThumb(width: CGFloat = Constants.APP.IMAGE_THUMB_WIDTH) -> UIImage {
    //        let oldWidth = self.size.width
    //
    //        // If image width is already equal to thumb width
    //        if oldWidth <= width {
    //            return self
    //        }
    //
    //        let scaleFactor = width / oldWidth
    //        let newWidth = oldWidth * scaleFactor
    //        let newHeight = self.size.height * scaleFactor
    //
    //        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: newHeight), false, 0)
    //        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    //        let image = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //
    //        return image ?? self
    //    }
    
    func tintColor(color: UIColor) {
        
    }
    
    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage? {
        let _: (CGFloat) -> CGFloat = {
            return $0 * (180.0 / CGFloat(Double.pi))
        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let image = self
        print(image.size)
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap?.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0)
        
        //   // Rotate the image context
        bitmap?.rotate(by: degreesToRadians(degrees))
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        bitmap?.scaleBy(x: yFlip, y: -1.0)
        let rect = CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height)
        
        bitmap?.draw(cgImage!, in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
