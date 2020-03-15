//
//  RegisterViewModel.swift
//  Flash Chat iOS13
//
//  Created by Oleksandr Hozhulovskyi on 15.03.2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewModel {
    var showChat: (() -> ())?
    
    func register(email: String?, pass: String?) {
        guard
            let email = email,
            let password = pass
        else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                //self.show(error)
            } else {
                self.showChat?()
            }
        }
    }
}
