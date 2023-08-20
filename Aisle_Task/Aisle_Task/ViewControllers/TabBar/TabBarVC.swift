//
//  TabBarVC.swift
//  Aisle_Task
//
//  Created by Ankit Dubey on 18/08/23.
//

import UIKit


class TabBarVC: UITabBarController,UpdateBadgeCount {
    
    // MARK: - Properties
    @IBOutlet weak var appTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<(self.viewControllers?.count ?? 0) {
            if let vc = self.viewControllers?[i] as? NotesVC {
                vc.delegate = self
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        appTabBar.barTintColor = .white
        self.selectedIndex = 1
                        
    }

    // MARK: - Updating Badge
    func didUpdate(count: String) {
        if let tabItems = appTabBar.items {
            let tabItem = tabItems[1]
            tabItem.badgeColor = UIColor(named: "BadgeColor")
            tabItem.badgeValue = count
        }
    }
    

}

// MARK: - CustomTabBar Class
///For managing the size of tab bar wrt to safe area.
class CustomTabBar : UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        guard let window = UIApplication.shared.currentUIWindow() else {
            return super.sizeThatFits(size)
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 60
        return sizeThatFits
    }
}
