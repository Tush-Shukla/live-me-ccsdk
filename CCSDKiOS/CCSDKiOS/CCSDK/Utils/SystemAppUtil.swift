//
//  SystemAppUtil.swift
//

import Foundation
import UIKit
import MessageUI
import CoreLocation
import MapKit

class SystemAppUtil: NSObject {
    
    class func initiateCall(number: String) {        
        if let url = URL(string: "tel://\(number.replacingOccurrences(of: " ", with: ""))"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
    
    class func openMaps(lat: Double, lng: Double, locationName: String) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(lat, lng)
        let regionSpan = MKCoordinateRegion.init(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = locationName
        mapItem.openInMaps(launchOptions: options)
    }
    
    class func openGoogleMaps(lat: Double, lng: Double, locationName: String) {
        //        if isGoogleMapsAvailable() {
        //            UIApplication.shared.openURL(URL(string:"comgooglemaps://?center=\(lat),\(lng)&zoom=20&views=traffic&q=\(locationName)")!)
        //        }else {
        let url = URL(string:"http://maps.google.com/?q=\(lat),\(lng)&z=17")!
        UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        //        }
    }
    
    class func openGoogleMaps(link: String) {
        if let url = URL(string: link) {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
    
    class func isGoogleMapsAvailable() -> Bool {
        return UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)
    }
    
    class func showMapsDialog(lat: Double, lng: Double, locationName: String, vc: UIViewController) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Apple Maps", style: .default, handler: { (action) in
            openMaps(lat: lat, lng: lng, locationName: locationName)
        }))
        sheet.addAction(UIAlertAction(title: "Google Maps", style: .default, handler: { (action) in
            openGoogleMaps(lat: lat, lng: lng, locationName: locationName)
        }))
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        vc.present(sheet, animated: true, completion: nil)
    }
    
    class func openMail(subject: String, body: String, recipents: [String], viewController: UIViewController, delegate: MFMailComposeViewControllerDelegate?) {
        let mc = MFMailComposeViewController()
        mc.setSubject(subject)
        mc.setMessageBody(body, isHTML: false)
        mc.setToRecipients(recipents)
        mc.mailComposeDelegate = delegate
        
        viewController.present(mc, animated: true, completion: nil)
    }
    
    class func open(link: String) {
        if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
            }else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    class func openShare(vc: UIViewController, message: String, url: String) {
        let url = URL(string: url)!
        let items = [message, url] as [Any]
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        //            activityController.excludedActivityTypes = [
        //                .airDrop, .postToTwitter, .mail, .message, .postToVimeo, .postToFlickr
        //            ]
        vc.present(activityController, animated: true, completion: nil)
    }
    
    /**
     Save image to photo library of device
     ```
     // Selector param signature
     func imageSavedCallback(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
     
     }
     ```
     - parameter image: The image to write to the Camera Roll album
     - parameter target: Optionally, the object whose selector should be called after the image has been written to the Camera Roll album.
     - parameter selector: The method selector of the completionTarget object to call. This optional method should conform to the following signature:
     - parameter info: An optional pointer to any context-specific data that you want passed to the completion selector.
     */
    
    class func saveImageToLibrary(image: UIImage, target: Any?, selector: Selector?, info: UnsafeMutableRawPointer?) {
        UIImageWriteToSavedPhotosAlbum(image, target, selector, info)
        /*selector method defination
         func imageSavedCallback(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
         
         }
         */
    }
    
    @discardableResult
    static func openAppSettings() -> Bool {
        guard
            let settingsURL = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingsURL)
            else {
                return false
        }
        
        UIApplication.shared.open(settingsURL)
        return true
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
