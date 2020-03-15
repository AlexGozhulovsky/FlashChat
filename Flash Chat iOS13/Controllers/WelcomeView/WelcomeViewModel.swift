//
//  WelcomeViewModel.swift
//  Flash Chat iOS13
//
//  Created by Oleksandr Hozhulovskyi on 15.03.2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

class WelcomeViewModel {
    var showLogin: (() -> ())?
    var showRegister: (() -> ())?
    
    func openLogin() {
        showLogin?()
    }
    
    func openRegister() {
        showRegister?()
    }
}
