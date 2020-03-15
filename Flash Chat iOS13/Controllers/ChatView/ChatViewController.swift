//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    var viewModel: ChatViewModel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        bindViewModel()
        viewModel.loadMessages()
    }
    
    func bindViewModel() {
        viewModel.reloadData = { [unowned self] in
            self.tableView.reloadData()
        }
        
        viewModel.scrollToRow = { [unowned self] indexPath in
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
        
        viewModel.clearInput = { [unowned self] in
            self.messageTextfield.text = nil
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        viewModel.send(message: messageTextfield.text)
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        viewModel.logOut()
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messageCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        let messageData = viewModel.messageDataAtRow(at: indexPath)
        cell.configure(text: messageData.text, viewMode: messageData.isUser ? .user : .other)
        
        return cell
    }
}

