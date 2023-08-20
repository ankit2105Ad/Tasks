//
//  OtpVC.swift
//  Aisle_Task
//
//  Created by Ankit Dubey on 18/08/23.
//

import UIKit

class OtpVC: BaseViewController {

    // MARK: - Properties
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var timerButton: UIButton!
    
    var timer: Timer?
    var totalTime = 60

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startOtpTimer()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func onTapEditButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapContinueButton(_ sender: Any) {
        
        callingVerifyOtpApi()
    }
    @IBAction func onTapResend(_ sender: Any) {
        
    }
    
    
    
    
    fileprivate func gotoNotesVC() {
        if  let tabBarVC = storyboard?.instantiateViewController(identifier: "TabBarVC") as? TabBarVC {
            navigationController?.pushViewController(tabBarVC, animated: true)
        }
    }
}

// MARK: - timer
extension OtpVC {
    
    private func startOtpTimer() {
        self.totalTime = 60
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        self.timerButton.setTitle(self.timeFormatted(self.totalTime), for: .normal)  // will show timer
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                self.timerButton.setTitle("Resend", for: .normal)
                self.timerButton.setTitleColor(.blue, for: .normal)
            }
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// MARK: - API Calling
extension OtpVC {
    
    func callingVerifyOtpApi() {
        if !self.checkInternetConnection(){ return }
        let phoneNumber = "+919876543212"
        let otp = "1234"

        let param = [APIParameter.number : phoneNumber, APIParameter.otp : otp]
        showHud()
        Networking.shared.callWebService(endPoint: EndPoint.verifyOtp, parameters: param, method: .post) { [weak self] (response) in
            self?.hideHud()
            if let data = response.data{
                do{
                    let decodedRsponse = try JSONDecoder.init().decode(VerifyOtp.self, from: data)
                    if let token = decodedRsponse.token {
                        UserDefaults.standard.setValue(token, forKey: APIParameter.authorization)
                        self?.gotoNotesVC()
                    } else {
                        self?.showAlert()
                    }
                }catch{
                    debugPrint(error)
                }
            }else{
                debugPrint("something wrong")
            }
        }
    }
}
