//
//  ToastUtil.swift
//  CCPartnerSDKiOS
//
//  Created by Abdul Wahib on 1/28/19.
//  Copyright © 2019 CustomerConnect. All rights reserved.
//

import Foundation
import KSToastView

class ToastUtil {
    
    enum Duration {
        case short
        case long
    }
    
    class func show(message: String, duration: Duration = .short) {
        KSToastView.ks_showToast(message, duration: duration == .short ? 1.0 : 3.0)
    }
}
