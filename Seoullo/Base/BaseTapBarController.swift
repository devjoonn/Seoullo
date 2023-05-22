//
//  BaseTapBarController.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import UIKit

class BaseTapBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarSetting()
        configureViewControllers()
        
    }
    
    //MARK: - Function
    private func configureViewControllers() {
        
        // 첫번째 탭
        let firstVC = ViewController()
        let nav1 = templateNavigationController(UIImage(systemName: "house"), UIImage(systemName: "house.fill"), title: "홈", viewController: firstVC)
        
        // 두번째 탭
        let secondVC = ViewController()
        let nav2 = templateNavigationController(UIImage(systemName: "message"), UIImage(systemName: "message.fill"), title: "채용공고", viewController: secondVC)
        
        // 세번째 탭
        let thirdVC = ViewController()
        let nav3 = templateNavigationController(UIImage(systemName: "heart"), UIImage(systemName: "heart.fill"), title: "찜", viewController: thirdVC)
        
        // 탭들 Setup
        viewControllers = [nav1, nav2, nav3]
    }
    
    // 네비게이션 컨트롤러 만들기
    private func templateNavigationController(_ image: UIImage?,_ selectImage: UIImage?, title: String,  viewController:UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.selectedImage = selectImage
        nav.tabBarItem.title = title
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.shadowColor = nil
        nav.navigationBar.standardAppearance = appearance;
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        nav.navigationItem.largeTitleDisplayMode = .never
        
        nav.navigationBar.tintColor = .white
        return nav
    }
    
    func tabBarSetting() {
        if #available(iOS 15.0, *){
            tabBar.tintColor = .blue
            tabBar.unselectedItemTintColor = .gray
            tabBar.backgroundColor = .white
            tabBar.barStyle = .black
            tabBar.layer.masksToBounds = false
            tabBar.isTranslucent = false
        }
    }
}
