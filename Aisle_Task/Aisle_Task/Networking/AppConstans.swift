//
//  ViewController.swift
//  Aisle_Task
//
//  Created by Ankit Dubey on 18/08/23.
//


import Foundation
import UIKit

enum EndPoint : String {
    
    case login                   = "/users/phone_number_login"
    case verifyOtp               = "/users/verify_otp"
    case profileList             = "/users/test_profile_list"
    
    func value() -> String {
        return self.rawValue
    }
    
}

// MARK:- API Parameter
public struct APIParameter {
    
    static let authorization     = "Authorization"
    static let number            = "number"
    static let otp               = "otp"
}

// MARK:- App URL
enum AppURL : String {

    case baseUrl   = "https://app.aisle.co/V1"
    
    public func path() -> String {
        return self.rawValue
    }
    
    public func url() -> URL? {
        return URL(string: self.rawValue)
    }
    
}
