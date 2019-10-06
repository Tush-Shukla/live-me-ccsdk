//
//  UrlUtil.swift
//

import Foundation

class UrlUtil {
    private static let URL_LINKS = FileUtil.readPlist(name: AppConstant.URL.API_URLS_FILE)
    
    static func getURL(for key: String) -> String {
        var url = ""
        guard let links = URL_LINKS else {return url}
        guard let endPoint = links.object(forKey: key) as? String else {return url}
        
        #if DEBUG
        url =  "\(links.object(forKey: AppConstant.URL.STAGE_URL_KEY) as? String ?? "")\(endPoint)"
        #else
        url =  "\(links.object(forKey: AppConstant.URL.PROD_URL_KEY) as? String ?? "")\(endPoint)"
        #endif
        return url
    }
    
    static func getURL(from path: String) -> String {
        var url = ""
        guard let links = FileUtil.readPlist(name: AppConstant.URL.API_URLS_FILE) else {return url}
        
        #if DEBUG
        url =  "\(links.object(forKey: AppConstant.URL.STAGE_URL_KEY) as? String ?? "")\(path)"
        #else
        url =  "\(links.object(forKey: AppConstant.URL.PROD_URL_KEY) as? String ?? "")\(path)"
        #endif
        return url
    }
    
    static func getImageUrl(for name: String) -> String {
        var url = ""
        guard let links = URL_LINKS else {return url}
        url =  "\(links.object(forKey: AppConstant.URL.IMAGES_URL_KEY) as? String ?? "")/\(name)"
        return url
    }
    
    static func getHeaders() -> [String: String] {
        return [
            AppConstant.Header.XAUTHORIZATION: PreferenceUtil.getAccessToken() ?? ""
        ]
    }
    
}
