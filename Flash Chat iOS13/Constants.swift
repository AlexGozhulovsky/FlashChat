//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Oleksandr Hozhulovskyi on 07.02.2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

struct K {
    static let appName = "⚡️FlashChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}

extension UIColor {
    struct BrandColors {
        static let purple = UIColor(named: "BrandPurple")!
        static let lightPurple = UIColor(named: "BrandLightPurple")!
        static let blue = UIColor(named: "BrandBlue")!
        static let lighBlue = UIColor(named: "BrandLightBlue")!
    }
}
