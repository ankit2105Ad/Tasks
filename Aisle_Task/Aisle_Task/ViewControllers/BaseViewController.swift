//
//  BaseViewController.swift
//  Aisle_Task
//
//  Created by Ankit Dubey on 18/08/23.
//

import Foundation
import UIKit
import JGProgressHUD

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    let hud = JGProgressHUD(style: .light)
    var actionRequiredRight:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func checkInternetConnection()->Bool {
        if Networking.isConnectedToInternet(){
            return true
        }else{
            self.showAlert("Message", "Please check internet connection")
            return false
        }
    }
    
    func showAlert(_ title : String = "Alert",_ message : String = "Something went wrong."){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
}

//MARK:- JGProgressHUD
extension BaseViewController{
    
    func showHud(){
        self.view.isUserInteractionEnabled = false
        hud.textLabel.text = "Please wait.."
        hud.show(in: self.view)
    }
    
    func hideHud(){
        self.view.isUserInteractionEnabled = true
        hud.dismiss()
    }
    
    func showMessageHud(message:String) {
        self.view.isUserInteractionEnabled = false
        hud.textLabel.text = message
        hud.show(in: self.view)
    }
    
    
}
