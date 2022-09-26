//
//  AppDelegate.swift
//  JuzStudio
//
//  Created by Ilyas Shomat on 31.08.2022.
//

import Foundation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        setupRootScene()
        
        return true
    }

    private func setupRootScene() {
        guard let window = window else { return }
        window.rootViewController = StudioMainViewController()
        window.makeKeyAndVisible()
    }
}
