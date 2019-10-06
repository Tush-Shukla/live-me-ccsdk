//
//  NotificationUtil.swift
//

import Foundation
import UIKit
import UserNotifications
import BRYXBanner

class NotificationUtil {
    
    class func registerForLocalNotifications() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            let options: UNAuthorizationOptions = [.alert, .sound, .badge];
            center.requestAuthorization(options: options) {
                (granted, error) in
                if !granted {
                    print("Notification permission not granted")
                }
            }
            
            center.getNotificationSettings { (settings) in
                if settings.authorizationStatus != .authorized {
                    // Notifications not allowed
                    print("Notification not authorized")
                }
            }
            
        } else {
            // Fallback on earlier versions
            let notificationSettings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        }
    }
    
    class func registerForPushNotifications() {
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    class func createLocalNotification(byDate date: Date, title: String, message: String, identifier: String) {
        if #available(iOS 10.0, *) {
            let notification = UNMutableNotificationContent()
            notification.title = title
            notification.body = message
            notification.sound = UNNotificationSound.default
            
            let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                        repeats: false)
            let identifier = identifier
            let request = UNNotificationRequest(identifier: identifier, content: notification, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (err) in
                if let e = err {
                    print(e.localizedDescription)
                }
            })
            
        } else {
            // Fallback on earlier versions
            let notification = UILocalNotification()
            notification.fireDate = Date()
            notification.alertBody = message
            notification.userInfo = ["uuid": identifier]
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
    
    class func removePendingNotification(identifier: String) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        } else {
            // Fallback on earlier versions
            if let notifications = UIApplication.shared.scheduledLocalNotifications {
                for i in 0..<notifications.count {
                    let notification = notifications[i]
                    if let userInfo = notification.userInfo {
                        if let uuid = userInfo["uuid"] as? String, uuid == identifier {
                            UIApplication.shared.scheduledLocalNotifications?.remove(at: i)
                        }
                    }
                }
            }
        }
    }
    
    // In App Notifications
    class func showInApp(title: String,
                                     message: String,
                                     image: UIImage?,
                                     backgroundColor: UIColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.00),
                                     titleColor: UIColor = .black,
                                     messageColor: UIColor = .black,
                                     duration: TimeInterval = 2.0,
                                     handler:(()->Void)?) {
        let banner = Banner(title: title,
                            subtitle: message,
                            image: nil,
                            backgroundColor: backgroundColor,
                            didTapBlock: handler)
        banner.dismissesOnTap = true
        banner.titleLabel.textColor = .black
        banner.detailLabel.textColor = .black
        banner.show(nil, duration: duration)
    }
    
}
