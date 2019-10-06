//
//  DialogUtil.swift
//

import Foundation
import SVProgressHUD

class DialogUtil {
    
    class func showProgress(message: String  = "Please Wait") {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        //        SVProgressHUD.setForegroundColor(UIColor(red: 2/255, green: 232/255, blue: 178/255, alpha: 1))
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.show(withStatus: message)
    }
    
    class func hideProgress() {
        SVProgressHUD.dismiss()
    }
    
    class func showMessage(title: String, message: String, controller: UIViewController, okHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action) -> Void in
            okHandler?()
        }
        
        alertController.addAction(dismissAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    class func showConfirmationDialog(title: String, message: String, controller: UIViewController, positive: UIAlertAction,negative: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(positive)
        alertController.addAction(negative)        
        controller.present(alertController, animated: true, completion: nil)
    }
    
}
