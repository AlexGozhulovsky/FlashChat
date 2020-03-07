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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                self.messages.removeAll()
                
                if let error = error {
                    self.show(error)
                } else {
                    guard let snapshotDocuments = querySnapshot?.documents else { return }
                    
                    self.uploadTableView(snapshotDocuments)
                }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        guard
            let messageBody = messageTextfield.text,
            let messegeSender = Auth.auth().currentUser?.email
        else { return }
        
        db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField: messegeSender,
            K.FStore.bodyField: messageBody,
            K.FStore.dateField: Date().timeIntervalSince1970
        ]) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.show(error)
                } else {
                    self.messageTextfield.text = nil
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            show(signOutError)
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        
        let viewMode: MessageCell.ViewMode = (message.sender == Auth.auth().currentUser?.email) ? .user : .other
        cell.configure(text: message.body, viewMode: viewMode)
        
        return cell
    }
    
    private func uploadTableView(_ snapshotData: [QueryDocumentSnapshot]) {
        for doc in snapshotData {
            let data = doc.data()
            
            guard
                let messageSender = data[K.FStore.senderField] as? String,
                let messageBody = data[K.FStore.bodyField] as? String
            else { continue }
            
            let newMessage = Message(sender: messageSender, body: messageBody)
            self.messages.append(newMessage)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
    }
    
    
}

