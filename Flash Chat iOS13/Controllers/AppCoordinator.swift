//
//  AppCoordinator.swift
//  Flash Chat iOS13
//
//  Created by Oleksandr Hozhulovskyi on 14.03.2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    var navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = window.rootViewController as! UINavigationController
    }

    func start() {
        let welcomeViewController = navigationController.topViewController as! WelcomeViewController
        
        let welcomeViewModel = WelcomeViewModel()
        welcomeViewModel.showRegister = showRegister
        welcomeViewModel.showLogin = showLogin
        
        welcomeViewController.viewModel = welcomeViewModel
    }
    
    func showChat() {
        let storyboard = navigationController.storyboard
        let chatViewController = storyboard?.instantiateViewController(identifier: "ChatViewController") as! ChatViewController
        let chatViewModel = ChatViewModel()
        chatViewModel.popToRoot = {
            self.navigationController.popToRootViewController(animated: true)
        }
        
        chatViewController.viewModel = chatViewModel
        
        navigationController.pushViewController(chatViewController, animated: true)
    }
    
    func showRegister() {
        let registerViewModel = RegisterViewModel()
        registerViewModel.showChat = showChat
        
        let storyboard = navigationController.storyboard
        let registerViewController = storyboard?.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        
        registerViewController.viewModel = registerViewModel
        
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func showLogin() {
        let storyboard = navigationController.storyboard
        let loginViewController = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        let loginViewModel = LoginViewModel()
        loginViewController.viewModel = loginViewModel
        loginViewModel.showChat = showChat
        
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
