//
//  NotesVC.swift
//  Aisle_Task
//
//  Created by Ankit Dubey on 18/08/23.
//

import UIKit
import Kingfisher

protocol UpdateBadgeCount {
    func didUpdate(count: String)
}

class NotesVC: BaseViewController {

    
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var profileImgView:UIImageView!
    @IBOutlet weak var nameAgeLbl:UILabel!
    
    var delegate:UpdateBadgeCount?
    
    private var dataToShow: Notes? = nil {
        didSet {
            self.collectionView.reloadData()
            self.setupUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        callNotesApi()

    }
    
    @IBAction func onTapUpgradeButton(_ sender: Any) {
    }
    
    // MARK: - Methods
    fileprivate func setupUI() {
        
        let nameAndAge = "\(dataToShow?.invites?.profilesUser?.first?.general_information?.first_name ?? ""), \(calcAge(birthday: dataToShow?.invites?.profilesUser?.first?.general_information?.date_of_birth ?? ""))"
        let badgeCount = "\(dataToShow?.likes?.likes_received_count ?? 0)"

        nameAgeLbl.text = nameAndAge
        let imageUrl = dataToShow?.invites?.profilesUser?.first?.photos?.filter({$0.selected == true})
        profileImgView.kf.setImage(with: URL(string: imageUrl?.first?.photo ?? ""))
        delegate?.didUpdate(count: badgeCount)
    }
}

// MARK: - API
extension NotesVC {
    
    fileprivate func callNotesApi() {
        if !self.checkInternetConnection(){ return }
        showMessageHud(message: "Please wait.")
        Networking.shared.callWebService(endPoint: EndPoint.profileList, method: .get) { [weak self] (response) in
            self?.hideHud()

            if let data = response.data{
                do{
                    let decodedRsponse = try JSONDecoder.init().decode(Notes.self, from: data)
                    if decodedRsponse.invites != nil {
                        self?.dataToShow = decodedRsponse
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
extension NotesVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataToShow?.likes?.profiles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imgToShow = dataToShow?.likes?.profiles?[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WhoLikedCell", for: indexPath) as? WhoLikedCell
        cell?.whoLikedImageView.kf.setImage(with: URL(string: imgToShow?.avatar ?? ""))
        if dataToShow?.likes?.can_see_profile == false {
            cell?.whoLikedImageView.applyBlurEffect()
        }
        return cell!
    }
    
    
}

