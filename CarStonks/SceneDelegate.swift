//
//  SceneDelegate.swift
//  CarStonks
//
//  Created by Amit on 04/03/2021.
//

import UIKit
import CarPlay

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var interfaceController: CPInterfaceController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}


extension SceneDelegate: CPTemplateApplicationSceneDelegate {
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
        didConnect interfaceController: CPInterfaceController) {
        
        // Store a reference to the interface controller so
        // you can add and remove templates as the user
        // interacts with your app.
        self.interfaceController = interfaceController
                
        let stonksTab = StockListTab(list: Config.stonkList)
        let cryptoTab = StockListTab(list: Config.cryptoList)
        
        let stockDataManager = StockDataManager()
        
        stockDataManager.registerTimer(for: [Config.stonkList,
                                            Config.cryptoList])
        
        stockDataManager.addObserver(stonksTab, forStockList: Config.stonkList.tabTitle)
        
        stockDataManager.addObserver(cryptoTab, forStockList: Config.cryptoList.tabTitle)

        let rootTemplate = CPTabBarTemplate(templates: [stonksTab.listTemplate, cryptoTab.listTemplate])
        interfaceController.setRootTemplate(rootTemplate, animated: true,
            completion: nil)
        
        stockDataManager.fetchDataNow([Config.stonkList,
                                       Config.cryptoList])
        
    }
}
