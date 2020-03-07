//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Oleksandr Hozhulovskyi on 08.02.2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet var messageBubble: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var rightImageView: UIImageView!
    
    @IBOutlet var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(text: String, viewMode: ViewMode) {
        label.text = text
        
        let isUser = (viewMode == .user)
        
        leftImageView.isHidden = isUser
        rightImageView.isHidden = !isUser
        messageBubble.backgroundColor = isUser ? UIColor.BrandColors.lightPurple : UIColor.BrandColors.purple
        label.textColor = isUser ? UIColor.BrandColors.purple : UIColor.BrandColors.lightPurple
    }
}

extension MessageCell {
    enum ViewMode {
        case user
        case other
    }
}
