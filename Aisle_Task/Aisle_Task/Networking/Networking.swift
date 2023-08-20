//
//  ViewController.swift
//  Aisle_Task
//
//  Created by Ankit Dubey on 18/08/23.
//

import Foundation
import Alamofire
import SwiftyJSON

class Networking {
    
    static let shared = Networking.init()
    
    let APIKey = "fa6d88f84b2b4ae887d152440232807"
    var headers : HTTPHeaders = ["X-Requested-With" : "XMLHttpRequest"]

    //MARK: - Check Connectivity
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func callWebService(endPoint:EndPoint, parameters:inout String, method: HTTPMethod,completion:@escaping (_ response:DataResponse<Any>) -> Void) {
        
        var url = path(endPoint)
        url = "\(url)?key=\(APIKey)\(parameters)"

        debugPrint("RequestURL: \(url)")
        debugPrint("RequestParam: \(String(describing: parameters))")
       
        Alamofire.request(url, method: method).responseJSON { (response :DataResponse<Any>) in
            // debugPrint(response)
            debugPrint("Response: \(String(describing: response.data?.printJSON()))")
            completion((response))
        }
    }
    
    func callWebService(endPoint:EndPoint,extendedURL:String? = nil,parameters: Parameters? = nil, method: HTTPMethod,completion:@escaping (_ response:DataResponse<Any>) -> Void) -> Void {
        let authToken = UserDefaults.standard.value(forKey: APIParameter.authorization) as? String ?? ""
        if !authToken.isEmpty {
            headers[APIParameter.authorization] = authToken
        }
        var url = path(endPoint)
        
        debugPrint("RequestURL: \(url)")
        debugPrint("RequestParam: \(String(describing: parameters))")
       
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response :DataResponse<Any>) in
            debugPrint("Response: \(String(describing: response.data?.printJSON()))")
            completion((response))
        }
    }
   
    fileprivate func path(_ endpoint:EndPoint) -> String {
        return  (AppURL.baseUrl).path() + endpoint.value()
    }

}

extension Data {
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print(JSONString)
        }
    }
}
