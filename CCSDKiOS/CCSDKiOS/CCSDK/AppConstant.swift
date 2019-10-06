//
//  AppConstant.swift
//

import Foundation

class AppConstant {
    
    class URL {
        static let API_URLS_FILE = "ApiUrls"
        static let STAGE_URL_KEY = "Stage"
        static let PROD_URL_KEY = "Production"
        
        static let STAGE_S3_URL_KEY = "StageS3"
        static let PROD_S3_URL_KEY = "ProductionS3"
        
        static let IMAGES_URL_KEY = "Images"
        
    }
    
    class Header {
        static let XAUTHORIZATION = "XAuthorization"
    }
    
    
    
    class Request {
        
        static let DATE_FORMAT = "dd-MM-yyyy HH:mm:ss"
        
        static let NAME = "name"
        static let EMAIL = "email"
        static let PASSWORD = "password"
        
        static let COORDINATES = "coordinates"
        static let PHONE = "phone"
        static let ADDRESS = "address"
        
        static let PAGE = "page"
        static let LIMIT = "limit"
        
        static let DEVICE_TOKEN = "deviceToken"
        
        static let ID = "id"
        static let TITLE = "title"
        static let DESCRIPTION = "description"
        static let FROM = "from"
        static let TO = "to"
        static let IMAGE = "image"
        
        static let IMAGE_ID = "image_id"
        static let IMAGE_NAME = "image.png"
        static let IMAGE_MIME_TYPE = "image/png"
        
        static let LAST_NAME = "lastName"
        static let FIRST_NAME = "firstName"
                
        static let DOB = "dob"
        static let ZIP_CODE = "zipCode"
        static let GENDER = "gender"
        
        static let SOURCE = "source"
        
        static let OLD_PASSWORD = "oldPassword"
        
        static let LAT = "lat"
        static let LNG = "lng"
        
        static let BAR_ID = "barId"
        
    }
    
    class Response {
        static let DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        static let STATUS = "status"
        static let MESSAGE = "message"
        static let DATA = "data"
    }
    
    class ResponseCode {
        static let OK = 200
        static let ERROR = 500
        static let TOKEN_EXPIRED = 8
    }
    
    class PrefKey {
        
        static let USER = "user"
        static let ACCESS_TOKEN = "accessToken"
        
        static let IS_NOTIFICATIONS_ENABLED = "isNotificationsEnabled"
        static let DEVICE_TOKEN = "deviceToken"
        
        static let IS_USER_LOGGED_IN = "isUserLoggedIn"
        
        static let EMAIL = "email"
        static let PASSWORD = "password"
        
        static let BAR_ID = "barId"
    }
}
