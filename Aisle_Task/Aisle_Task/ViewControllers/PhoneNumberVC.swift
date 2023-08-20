//
//  ViewController.swift
//  Aisle_Task
//
//  Created by Ankit Dubey on 18/08/23.
//

import UIKit

class PhoneNumberVC: BaseViewController {

    // MARK: - Properties
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }


    func setupUI() {

    }

    @IBAction func onTapContinue(_ sender: Any) {
        callingLoginApi()
    }
    
}

// MARK: - Methods
extension PhoneNumberVC {
    
    fileprivate func gotoOtpVC() {
        if  let otpVC = storyboard?.instantiateViewController(identifier: "OtpVC") as? OtpVC {
            navigationController?.pushViewController(otpVC, animated: true)
        }
    }
}

// MARK: - API Calling
extension PhoneNumberVC {
    
    func callingLoginApi() {
        if !self.checkInternetConnection(){ return }
        let phoneNumber = "+919876543212"
        let param = [APIParameter.number : phoneNumber]
        showHud()
        Networking.shared.callWebService(endPoint: EndPoint.login, parameters: param, method: .post) { [weak self] (response) in
            self?.hideHud()
            if let data = response.data{
                do{
                    let decodedRsponse = try JSONDecoder.init().decode(LoginResponse.self, from: data)
                    if decodedRsponse.status == true {
                        self?.gotoOtpVC()
                    } else {
                        self?.showAlert()
                    }
                }catch{
                    debugPrint(error)
                }
            }else{
            }
        }
    }
}
