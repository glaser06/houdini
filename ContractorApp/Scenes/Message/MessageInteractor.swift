//
//  MessageInteractor.swift
//  ContractorApp
//
//  Created by Zaizen Kaegyoshi on 10/25/17.
//  Copyright (c) 2017 Team5. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Firebase
import Photos

protocol MessageBusinessLogic
{
    func fetchMessages()
    func sendMessage(request: Message.SendMessage.Request)
    func configureDatabase()
    func configureStorage()
    func sendImage(request: Message.SendImage.Request)
}

protocol MessageDataStore
{
    var messages: [GenericMessage]! { get set }
    var conversation: Conversation! { get set }
}

class MessageInteractor: MessageBusinessLogic, MessageDataStore
{
    var presenter: MessagePresentationLogic?
    var worker: MessageWorker?
    var name: String = ""
    var messages: [GenericMessage]! = []
    var ref: DatabaseReference!
    var storageRef: StorageReference!
    fileprivate var _refHandle: DatabaseHandle!
    
    var conversation: Conversation!
    
    // MARK: Do something
    
    func fetchMessages() {
        self.presenter?.presentMessages(response: Message.FetchMessages.Response(userName: Auth.auth().currentUser?.displayName ?? "", businessName: conversation.business.name,messages: self.messages))
    }
    func sendMessage(request: Message.SendMessage.Request) {
        
        let data = ["text": request.message.message]
        
        var mdata = data
        mdata["name"] = Auth.auth().currentUser?.displayName ?? ""
        if let photoURL = Auth.auth().currentUser?.photoURL {
            mdata["photoURL"] = photoURL.absoluteString
        }
        
        // Push data to Firebase Database
        self.ref.child("messages").childByAutoId().setValue(mdata)
        
//        let msg = request.message
//        self.messages.insert(msg, at: 0)
//        let another = Message.Message(message: "Hi! Doorknob replacements typically cost around $35-50 for parts and labor. If you’re available this week, I can come in to take a look at it.", sender: "Other")
//        self.messages.insert(another, at: 0)
        self.presenter?.presentMessages(response: Message.FetchMessages.Response(userName: Auth.auth().currentUser?.displayName ?? "", businessName: conversation.business.name,  messages: self.messages))
    }
    func configureDatabase() {
        ref = Database.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("messages").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            guard let msg = snapshot.value as? [String: String] else { return }
            let name = msg["name"] ?? ""
            let text = msg["text"] ?? ""
            var img: UIImage?
            
            if let imageURL = msg["ImageURL"] {
                if imageURL.hasPrefix("gs://") {
                    Storage.storage().reference(forURL: imageURL).getData(maxSize: INT64_MAX) {(data, error) in
                        if let error = error {
                            print("Error downloading: \(error)")
                            return
                        }
                        img = UIImage(data: data!)
                        var message: GenericMessage
                        if img != nil {
                            message = Message.ImageMessage(message: "", sender: name, image: img)
                        } else {
                            message = Message.Message(message: text, sender: name)
                        }
                        
                        
                        strongSelf.messages.insert(message, at: 0)
                        strongSelf.presenter?.presentMessages(response: Message.FetchMessages.Response(userName: Auth.auth().currentUser?.displayName ?? "", businessName: strongSelf.conversation.business.name,messages: strongSelf.messages))
                        
                    }
                } else if let URL = URL(string: imageURL), let data = try? Data(contentsOf: URL) {
                    img = UIImage.init(data: data)
                    var message: GenericMessage
                    if img != nil {
                        message = Message.ImageMessage(message: "", sender: name, image: img)
                    } else {
                        message = Message.Message(message: text, sender: name)
                    }
                    
                    
                    strongSelf.messages.insert(message, at: 0)
                    strongSelf.presenter?.presentMessages(response: Message.FetchMessages.Response(userName: Auth.auth().currentUser?.displayName ?? "", businessName: strongSelf.conversation.business.name,messages: strongSelf.messages))
                }
//                cell.textLabel?.text = "sent by: \(name)"
            }
            var message: GenericMessage
            if img != nil {
                message = Message.ImageMessage(message: "", sender: name, image: img)
            } else {
                message = Message.Message(message: text, sender: name)
            }
            
            
            strongSelf.messages.insert(message, at: 0)
            strongSelf.presenter?.presentMessages(response: Message.FetchMessages.Response(userName: Auth.auth().currentUser?.displayName ?? "", businessName: strongSelf.conversation.business.name,messages: strongSelf.messages))
//            strongSelf.clientTable.insertRows(at: [IndexPath(row: strongSelf.messages.count-1, section: 0)], with: .automatic)
        })
    }
    func configureStorage() {
        storageRef = Storage.storage().reference()
    }
    deinit {
        if let refHandle = _refHandle {
            self.ref.child("messages").removeObserver(withHandle: _refHandle)
        }
    }
    func sendMessage(withData data: [String: String]) {
        var mdata = data
        mdata["name"] = Auth.auth().currentUser?.displayName ?? ""
        if let photoURL = Auth.auth().currentUser?.photoURL {
            mdata["photoURL"] = photoURL.absoluteString
        }
        
        // Push data to Firebase Database
        self.ref.child("messages").childByAutoId().setValue(mdata)
        
        //        self.clientTable.scrollToRow(at: <#T##IndexPath#>, at: <#T##UITableViewScrollPosition#>, animated: <#T##Bool#>)
    }
    func sendImage(request: Message.SendImage.Request) {
        let info = request.info
        let uid = Auth.auth().currentUser!.uid
        // if it's a photo from the library, not an image from the camera
        if #available(iOS 8.0, *), let referenceURL = info[UIImagePickerControllerReferenceURL] as? URL {
            let assets = PHAsset.fetchAssets(withALAssetURLs: [referenceURL], options: nil)
            let asset = assets.firstObject
            asset?.requestContentEditingInput(with: nil, completionHandler: { [weak self] (contentEditingInput, info) in
                let imageFile = contentEditingInput?.fullSizeImageURL
                let filePath = "\(uid)/\(Int(Date.timeIntervalSinceReferenceDate * 1000))/\((referenceURL as AnyObject).lastPathComponent!)"
                guard let strongSelf = self else { return }
                strongSelf.storageRef.child(filePath)
                    .putFile(from: imageFile!, metadata: nil) { (metadata, error) in
                        if let error = error {
                            let nsError = error as NSError
                            print("Error uploading: \(nsError.localizedDescription)")
                            return
                        }
                        strongSelf.sendMessage(withData: ["ImageURL": strongSelf.storageRef.child((metadata?.path)!).description])
                }
            })
        } else {
            guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            let imageData = UIImageJPEGRepresentation(image, 0.8)
            let imagePath = "\(uid)/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            self.storageRef.child(imagePath)
                .putData(imageData!, metadata: metadata) { [weak self] (metadata, error) in
                    if let error = error {
                        print("Error uploading: \(error)")
                        return
                    }
                    guard let strongSelf = self else { return }
                    strongSelf.sendMessage(withData: ["ImageURL": strongSelf.storageRef.child((metadata?.path)!).description])
            }
        }
    }
        
    
}