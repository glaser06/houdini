//
//  MessageViewController.swift
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
import SlackTextViewController
import Firebase
import Photos

protocol MessageDisplayLogic: class
{
    func displayMessages(vm: Message.FetchMessages.ViewModel)
}

class MessageViewController: SLKTextViewController, MessageDisplayLogic, UINavigationControllerDelegate
{
    var interactor: MessageBusinessLogic?
    var router: (NSObjectProtocol & MessageRoutingLogic & MessageDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
//        super.init(tableViewStyle: .plain)
        setup()
    }
    
    override class func tableViewStyle(for decoder: NSCoder) -> UITableViewStyle {
        
        return .plain
    }
    
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = MessageInteractor()
        let presenter = MessagePresenter()
        let router = MessageRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    var messages: [GenericMessage] = []
    
    var name: String = "self" // for self
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.leftButton.setImage(#imageLiteral(resourceName: "plus-black"), for: .normal)
        self.leftButton.tintColor = UIColor.red
        
        
        self.tableView?.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: MessageCellIdentifier + "1")
        self.tableView?.register(UINib(nibName: "ReceiverMessageCell", bundle: nil), forCellReuseIdentifier: MessageCellIdentifier + "2")
        self.tableView?.register(UINib(nibName: ImageMessageTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ImageMessageTableViewCell.identifier)
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        self.tableView?.estimatedRowHeight = 200
        self.tableView?.separatorStyle = .none
        self.tableView?.allowsSelection = false
        self.interactor?.configureDatabase()
        self.interactor?.configureStorage()
        fetchMessages()
        
        
        
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func fetchMessages() {
        self.interactor?.fetchMessages()
    }
    func sendMessage() {
        self.interactor?.sendMessage(request: Message.SendMessage.Request(message: Message.Message(message: self.textView.text!, sender: self.name)))
    }
    func sendQuote() {
        let alertController = UIAlertController(title: "Price Quote", message: "", preferredStyle: .alert)
        let sendAction = UIAlertAction(title: "Send", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
//            let secondTextField = alertController.textFields![1] as UITextField
            
//            print("firstName \(firstTextField.text), secondName \(secondTextField.text)")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter an amount"
        }
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Enter Second Name"
//        }
        
        alertController.addAction(sendAction)
        alertController.addAction(cancelAction)
    }
    func displayMessages(vm: Message.FetchMessages.ViewModel) {
        self.messages = vm.messages
        self.titleLabel.text = vm.businessName
        self.tableView?.reloadData()
    }
    func addActionSheet() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.showCamera()
        }
        let quote = UIAlertAction(title: "Quote", style: .default) { (action) in
            self.sendQuote()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(camera)
        sheet.addAction(cancel)
        self.navigationController?.present(sheet, animated: true, completion: nil)
        
    }
    func showCamera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            picker.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        self.present(picker, animated: true, completion:nil)
    }
    
    // MARK: Firebase stuff
    
    
}
extension MessageViewController {
    // MARK: Table methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messages[indexPath.row]
        
        var cell: UITableViewCell
        if message.sender == Auth.auth().currentUser!.uid {
            if let m = message as? Message.ImageMessage {
                var a = tableView.dequeueReusableCell(withIdentifier: ImageMessageTableViewCell.identifier) as! ImageMessageTableViewCell
                a.setCell(img: m.image!)
                cell = a
                
            } else {
                var a = tableView.dequeueReusableCell(withIdentifier: MessageCellIdentifier+"1") as! MessageTableViewCell
                a.setCell(message: message.message)
                cell = a
            }
            
        } else {
            var a = tableView.dequeueReusableCell(withIdentifier: MessageCellIdentifier+"2") as! MessageTableViewCell
            a.setCell(message: message.message)
            cell = a
        }
        
        
        cell.transform = tableView.transform
        return cell
        
        
        
    }
}
extension MessageViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
extension MessageViewController {
    // MARK: Overwrite methods
    override func didPressLeftButton(_ sender: Any?) {
        super.didPressLeftButton(sender)
        
        self.showCamera()
    }
    override func didPressRightButton(_ sender: Any?) {
        self.textView.refreshFirstResponder()
        
        let message = Message.Message(message: self.textView.text, sender: self.name)
//        message.username =
//        message.text = self.textView.text
        
        let indexPath = IndexPath(row: 0, section: 0)
        let rowAnimation: UITableViewRowAnimation = self.isInverted ? .bottom : .top
        let scrollPosition: UITableViewScrollPosition = self.isInverted ? .bottom : .top
        
        self.tableView?.beginUpdates()
        self.messages.insert(message, at: 0)
        self.tableView?.insertRows(at: [indexPath], with: rowAnimation)
        
        self.tableView?.endUpdates()
        
        
        self.tableView?.scrollToRow(at: indexPath, at: scrollPosition, animated: true)
        self.sendMessage()
        
        // Fixes the cell from blinking (because of the transform, when using translucent cells)
        // See https://github.com/slackhq/SlackTextViewController/issues/94#issuecomment-69929927
        self.tableView?.reloadRows(at: [indexPath], with: .automatic)
        
        super.didPressRightButton(sender)
        
    }
}
extension MessageViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion:nil)
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        self.interactor?.sendImage(request: Message.SendImage.Request(info: info))
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}



