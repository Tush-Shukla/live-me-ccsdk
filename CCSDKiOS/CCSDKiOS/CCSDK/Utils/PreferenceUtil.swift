//
//  PreferenceUtil.swift
//

import Foundation

class PreferenceUtil {
    
    // MARK: Save Values
    class func save(key: String, value: String?){
        UserDefaults.standard.setValue(value, forKey: key)
    }
    
    class func save(key: String, value: Int){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func save(key: String, value: Double){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func save(key: String, value: Bool){
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func save(key: String, value: NSDictionary) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    class func save(key: String, value: NSArray) {
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    // MARK: Get Values
    class func get(key:String) -> String? {
        return UserDefaults.standard.value(forKey: key) as? String
    }
    
    class func get(key:String, default defaultValue: String?) -> String? {
        let string = UserDefaults.standard.value(forKey: key) as? String
        return string != nil ? string : defaultValue
    }
    
    class func getInt(key:String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }
    
    class func getDouble(key:String) -> Double {
        return UserDefaults.standard.double(forKey: key)
    }
    
    class func getBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    class func getDictionary(key: String) -> NSDictionary? {
        return UserDefaults.standard.object(forKey: key) as? NSDictionary
    }
    
    class func getArray(key: String) -> NSArray? {
        if let data = UserDefaults.standard.object(forKey: key) as? NSData {
            if let items = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSArray {
                return items
            }
        }
        return nil
    }
    
    // MARK: Delete Values
    class func delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}

extension PreferenceUtil {
    
    // MARK: Save Values
    class func save(user: User) {
        save(key: AppConstant.PrefKey.USER, value: user.dictionaryRepresentation())
        save(key: AppConstant.PrefKey.IS_USER_LOGGED_IN, value: true)
        if let token = user.token {
            save(accessToken: token)
        }
    }
    
    class func save(accessToken token: String) {
        save(key: AppConstant.PrefKey.ACCESS_TOKEN, value: token)
    }
    
    class func save(deviceToken token: String) {
        save(key: AppConstant.PrefKey.DEVICE_TOKEN, value: token)
    }
    
    // MARK: Get Values
    class func getUser() -> User {
        if let dic = getDictionary(key: AppConstant.PrefKey.USER), let user = User(dictionary: dic) {
            return user
        }
        return User(dictionary: [:])!
    }
    
    class func getAccessToken() -> String? {
        return get(key: AppConstant.PrefKey.ACCESS_TOKEN)
    }
    
    class func getDeviceToken() -> String? {
        return get(key: AppConstant.PrefKey.DEVICE_TOKEN)
    }
    
    class func isLoggedIn() -> Bool {
        return PreferenceUtil.getBool(key: AppConstant.PrefKey.IS_USER_LOGGED_IN)
    }
    
    // MARK: Clear Values
    class func clearLoggedUserData() {
        save(key: AppConstant.PrefKey.IS_USER_LOGGED_IN, value: false)
        delete(key: AppConstant.PrefKey.USER)
        delete(key: AppConstant.PrefKey.ACCESS_TOKEN)        
    }
    
}

