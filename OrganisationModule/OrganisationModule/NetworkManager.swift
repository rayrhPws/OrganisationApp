
//  NetworkManager.swift

import Foundation
import Alamofire

/**
 NetworkManager class is the layer which is responbile for all type of network communication of application.
 */

class NetworkManager : NSObject {
    
    func request<T: Decodable>(_ endPoint: String,
                               method: HTTPMethod = .get,
                               parameters: Parameters? = nil,
                               encoding: ParameterEncoding = URLEncoding.default,
                               headers: HTTPHeaders? = nil,
                               modelType: T.Type = EmptyModel.self as! T.Type,
                               success: @escaping (_ result: Any?) -> Void,
                               failure: @escaping (_ error: NSError?) -> Void) {
        
        
        
        let url = Constants.shared.baseUrl
        
        let performRequest: () -> () = {
            
            
//            print("HEADERS: \(headers)")
            
            let request = AF.request(url,
                                     method: method,
                                     parameters: parameters,
                                     encoding: encoding,
                                     headers: headers)
            
            if modelType == EmptyModel.self {
                request.validate()
//                    .redirect(using: redirector)
                    .response { (response) in
                        switch response.result {
                        case .success(let responseObject):
                            success(responseObject)
                        case .failure(let error):
                            failure(self.handleError(error, responseData: response.data))
                        }
                    }
            } else {
                request.validate()
//                    .redirect(using: redirector)
                    .responseDecodable(of: T.self) { (response) in
                        switch response.result {
                        case .success(let responseObject):
                            success(responseObject)
                        case .failure(let error):
                            failure(self.handleError(error, responseData: response.data))
                        }
                    }
            }
        }
        
        //        if isAuthTokenNeeded {
        //            if Helper.isTokenValid() {
        //                performRequest()
        //            } else {
        //                self.refreshTokenAndContinue(successAction: {
        //                    performRequest()
        //                })
        //            }
        //        } else {
        //            performRequest()
        //        }
        performRequest()
    }
}

extension NetworkManager {
    func handleError(_ error: AFError, responseData: Data?) -> NSError {
        
        var errorResponseBody:[String:Any]?
        if let data = responseData {
            let json = String(data: data, encoding: String.Encoding.utf8)
            errorResponseBody = Helper.convertToDictionary(json ?? "")
        }
        
        var userInfo:[String : Any] = [:]
        switch error.responseCode ?? 0 {
        case 400..<500:
            userInfo[NSLocalizedDescriptionKey] = errorResponseBody?["Message"]
        case 500..<600:
            userInfo[NSLocalizedDescriptionKey] = errorResponseBody?["Message"]
        default:
            if errorResponseBody?["Message"] != nil && errorResponseBody?["Message"] as! String != "" {
                userInfo[NSLocalizedDescriptionKey] = errorResponseBody?["Message"]
            } else {
                userInfo[NSLocalizedDescriptionKey] = "some error occured"
            }
            if !(NetworkReachabilityManager()?.isReachable ?? false) {
                userInfo[NSLocalizedDescriptionKey] = "internet not found"
//                userInfo[ErrorCodes.networkError] = true
            }
        }
        
        if let errorResponseBody = errorResponseBody {
            userInfo = userInfo.merging(errorResponseBody) { (_, new) in new }
        }
       
        
        return NSError(domain: "", code: error.responseCode ?? 0, userInfo: userInfo)
    }
    

    
    

                                    
}



