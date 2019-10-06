//
//  ApiManager.swift
//

import Foundation
import Alamofire
import Crashlytics

class RestApiHelper {
    
    
    private static let headers = ["cache-control": "no-cache"]
    
    // GET Request
    static func get(url: String,
                    parameters: [String: Any]?,
                    headers: HTTPHeaders? = headers,
                    success: @escaping (_ response: Any)->Void,
                    failure: @escaping (_ code: Int?, _ message: String? )->Void  ) {
        Alamofire.request(url,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: headers)
            .validate(statusCode: 200..<500)
            .responseJSON { (response) in
                handle(response: response, success: success, failure: failure)
        }
    }
    
    // POST Request
    static func post(http url: String,
                     parameters: [String: Any]?,
                     headers: HTTPHeaders? = headers,
                     success: @escaping (_ response: Any)->Void,
                     failure: @escaping (_ code: Int?, _ message: String? )->Void  ) {
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.httpBody,
                          headers: headers)
            .validate(statusCode: 200..<500)
            .responseJSON { (response) in
                handle(response: response, success: success, failure: failure)
        }
    }
    
    static func post(json url: String,
                     parameters: [String: Any]?,
                     headers: HTTPHeaders? = headers,
                     success: @escaping (_ response: Any)->Void,
                     failure: @escaping (_ code: Int?, _ message: String? )->Void  ) {
        Alamofire.request(url,
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .validate(statusCode: 200..<500)
            .responseJSON { (response) in
                handle(response: response, success: success, failure: failure)
        }
    }
    
    static func post(multipart url: String,
                     parameters: [String: Any]?,
                     files: [Data]?,
                     headers: HTTPHeaders? = headers,
                     success: @escaping (_ response: Any)->Void,
                     failure: @escaping (_ code: Int?, _ message: String? )->Void  ) {
        
        Alamofire.upload(
            multipartFormData: { (formData) in
                guard let params = parameters else {return}
                for (key, value) in params {
                    formData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                guard let files = files else {return}
                for data in files{
                    formData.append(data,
                                    withName: AppConstant.Request.IMAGE_ID,
                                    fileName: AppConstant.Request.IMAGE_NAME,
                                    mimeType: AppConstant.Request.IMAGE_MIME_TYPE)
                }
        }, usingThreshold: UInt64.init(),
           to: url,
           method: .post,
           headers: headers)
        {(result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if response.error != nil{
                        guard let json = response.result.value as? NSDictionary else {
                            failure(nil, "Unable to parse response")
                            return
                        }
                        success(json)
                    }else {
                        failure(nil, nil)
                    }
                }
                break
            case .failure(let error):
                Crashlytics.sharedInstance().recordError(error)
                failure(nil, error.localizedDescription)
                break
            }
        }
        
    }
    
    // Response Handling
    static func handle(response: DataResponse<Any>,
                       success: @escaping (_ response: Any)->Void,
                       failure: @escaping (_ code: Int?, _ message: String? )->Void) {
        switch response.result {
        case .success:
            guard let data = response.result.value as? NSDictionary else {
                return failure(nil, "Unable to get data")
            }
            guard let json = StandardResponse.init(dictionary: data) else {
                return failure(nil, "Unable to parse response")
            }
            
            if json.status == AppConstant.ResponseCode.OK, let res = json.data {
                success(res)
            }else {
                failure(json.status, json.message)
            }
        case .failure(let error):
            Crashlytics.sharedInstance().recordError(error)
            failure(nil, error.localizedDescription)
        }
    }
    
    // Download Functions
    static func download(data url: String,
                         progress: ((_ completed: Double)->Void)?,
                         success: @escaping (_ response: Data?)->Void,
                         failure: @escaping (_ error: Error)->Void  ) {
        
        Alamofire.download(url)
            .downloadProgress(closure: { (completed) in
                progress?(completed.fractionCompleted)
            })
            .responseData { response in
                
                switch response.result {
                case .success:
                    success(response.result.value)
                case .failure(let error):
                    Crashlytics.sharedInstance().recordError(error)
                    failure(error)
                }
        }
    }
    
}
