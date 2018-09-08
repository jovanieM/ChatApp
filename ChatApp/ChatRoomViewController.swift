//
//  ChatRoomViewController.swift
//  ChatApp
//
//  Created by CebuSQA on 04/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ChatRoomViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate{
    
   
    
//    let containerView:UIView = {
//        let uiView: UIView = UIView()
//        uiView.backgroundColor = .red
//        uiView.translatesAutoresizingMaskIntoConstraints = false
//        return uiView
//    }()
    
    var user: User? {
        didSet{
//            observeMessages()
        }
    }
    
    let logoutBtn: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Logout", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        button.backgroundColor = .blue
        return button
    }()
    
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        textField.backgroundColor = .blue
        textField.placeholder = "enter message..."
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    

    
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 50, right: 0)
        collectionView?.alwaysBounceVertical = true
        //collectionView?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        collectionView?.backgroundColor = .white
        collectionView?.register(MessagesViewCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationItem.title = "Chat app"
        navigationController?.navigationBar.barTintColor = .white
//        navigationController?.setToolbarHidden(false, animated: false)
//        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 32))
//        tf.borderStyle = .roundedRect
//        tf.background = UIImage(named: "textfield_bg")
        
    
        
        let rightBarButton = UIBarButtonItem(customView: logoutBtn)
        navigationItem.rightBarButtonItems = [rightBarButton]
        setupInputComponents()
        //setupTableView()

        observeMessages()
       
        // Do any additional setup after loading the view.
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessagesViewCell
        
        let message = messages[indexPath.item]
        cell.messageTextView.text = message.text
        cell.userTextLabel.text = message.sender
        
        cell.chatBubbleWidthAnchor?.constant = estimatedFrameForText(text: message.text!).width + 32
        return cell
    }
    // collectionViewlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        if let text = messages[indexPath.item].text {
            height = estimatedFrameForText(text: text).height + 40
        }
        
        // get estimated height
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func estimatedFrameForText(text: String) -> CGRect{
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)],
                                                   context: nil)
    }
    
    func setupInputComponents(){
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        // add constraints
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor).isActive  = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        //send button
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        containerView.addSubview(sendButton)
        //send button constraints
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        //textfield
        containerView.addSubview(inputTextField)
        
        //inputText constraints
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        //separator line
        let separatorline = UIView()
        separatorline.backgroundColor = .black
        separatorline.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorline)
        //consttraints
        separatorline.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorline.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorline.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorline.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    func setupTableView(){
   
    }

    @objc func sendMessage(){
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let values = ["text": inputTextField.text!, "sender": "midoriya"]
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil{
                return
            }
            self.inputTextField.text = nil
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    var messages = [Message]()
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
           // let val = snapshot.value

        
            if let dictionary = snapshot.value as? [String: String] {
                print("\(dictionary.debugDescription)")
                let msg = Message()
                msg.sender = dictionary["sender"]
                msg.text = dictionary["text"]
                //msg.setValuesForKeys(dictionary)
                
               self.messages.append(msg)
//
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }

                // todo
                // reload data of collectionview
            }
        }, withCancel: nil)
    }

}
