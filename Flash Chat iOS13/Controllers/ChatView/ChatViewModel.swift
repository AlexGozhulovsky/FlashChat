//
//  ChatViewModel.swift
//  Flash Chat iOS13
//
//  Created by Oleksandr Hozhulovskyi on 14.03.2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

struct MessageData {
    let text: String
    let isUser: Bool
}

class ChatViewModel {
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    var messageCount: Int {
        return messages.count
    }
    
    var clearInput: (() -> ())?
    var reloadData: (() -> ())?
    var scrollToRow: ((IndexPath) -> ())?
    var popToRoot: (() -> ())?
    
    func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                self.messages.removeAll()
                
                if let error = error {
                    print(error)
                } else {
                    guard let snapshotDocuments = querySnapshot?.documents else { return }
                    
                    self.uploadTableView(snapshotDocuments)
                }
        }
    }
    
    func uploadTableView(_ snapshotData: [QueryDocumentSnapshot]) {
        for doc in snapshotData {
            let data = doc.data()
            
            guard
                let messageSender = data[K.FStore.senderField] as? String,
                let messageBody = data[K.FStore.bodyField] as? String
            else { continue }
            
            let newMessage = Message(sender: messageSender, body: messageBody)
            self.messages.append(newMessage)
            
            DispatchQueue.main.async {
                self.reloadData?()
                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                self.scrollToRow?(indexPath)
            }
        }
    }
    
    func send(message: String?) {
        guard
            let messageBody = message,
            let messegeSender = Auth.auth().currentUser?.email
        else { return }
        
        db.collection(K.FStore.collectionName).addDocument(data: [
            K.FStore.senderField: messegeSender,
            K.FStore.bodyField: messageBody,
            K.FStore.dateField: Date().timeIntervalSince1970
        ]) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    self.clearInput?()
                }
            }
        }
    }
    
    func messageDataAtRow(at indexPath: IndexPath) -> MessageData {
        let message = messages[indexPath.row]
        
        return MessageData(text: message.body, isUser: (message.sender == Auth.auth().currentUser?.email))
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            popToRoot?()
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
}
