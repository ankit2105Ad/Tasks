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
    
    var headers : HTTPHeaders = ["X-Requested-With" : "XMLHttpRequest"]

    //MARK: - Check Connectivity
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
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
