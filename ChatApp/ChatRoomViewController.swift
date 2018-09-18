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
    
    var user: User?
    var messages = [Message]()
    let cellId = "cellId"
    var safeAreaBottomInset: CGFloat?
    var containerViewBottomAnchor: NSLayoutConstraint?
    let messagesRef = Database.database().reference()
    
    let containerView:UIView = {
        let uiView: UIView = UIView()
        uiView.backgroundColor = .white
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let logoutBtn: UIBarButtonItem = {
        
        let btn = UIButton(type: .custom)
        btn.setTitle("Log out", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.transform = CGAffineTransform(translationX: 10, y: 0)
        btn.layer.backgroundColor = UIColor.appColorDarkGray.cgColor
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        let button = UIBarButtonItem(customView: btn)
        button.width = 63
        return button
    }()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Start a new message",
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.appColorLightGray,
                                                                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        textField.borderStyle = .none
        textField.layer.cornerRadius = 5
        textField.layer.masksToBounds = true
        textField.setLeftPaddingPoints(10)
        textField.backgroundColor = UIColor.appColorAliceBlue
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    let safeAreaInsetCoverView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let navigationBarSeparatorLine: UIView = {
        let separatorline = UIView()
        separatorline.backgroundColor = UIColor.appColorLineGray
        separatorline.translatesAutoresizingMaskIntoConstraints = false
        return separatorline
    }()
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        observeMessages()
        navigationItem.title = "Chat app"
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItems = [logoutBtn]
        logoutBtn.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoutUser)))
        setupInputComponents()
        
        collectionView?.contentInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 47.5, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
        collectionView?.register(MessagesViewCell.self, forCellWithReuseIdentifier: cellId)
     
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardObserver), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardObserver), name: NSNotification.Name.UIKeyboardWillShow,object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        if safeAreaBottomInset == nil {
            if #available(iOS 11.0, *) {
                view.addSubview(safeAreaInsetCoverView)
                safeAreaBottomInset = view.safeAreaInsets.bottom
                safeAreaInsetCoverView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
                safeAreaInsetCoverView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
                safeAreaInsetCoverView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                safeAreaInsetCoverView.heightAnchor.constraint(equalToConstant: view.safeAreaInsets.bottom).isActive = true
            } else {
                // Fallback on earlier versions
                print("no safeAreaInsets")
                safeAreaBottomInset = 0
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    

    @objc func logoutUser(){
    
        self.messagesRef.removeAllObservers()
        self.dismiss(animated: true, completion: nil)
     
    }
    
    // adjust collection view contents when keyboard appears
    @objc func keyboardObserver(notification: Notification) {
    
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            containerViewBottomAnchor?.constant = isKeyboardShowing ? (-keyboardFrame!.height) : 0
            
    
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (comleted) in
                if isKeyboardShowing {
                    
                    guard self.messages.count > 1 else {return}
                    let indexPath = IndexPath(item: self.messages.count
                         - 1, section: 0)
                    self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
    }
    
    
    private func estimatedFrameForText(text: String) -> CGRect{
        
        let size = CGSize(width: view.frame.width * 0.8, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)],
                                                   context: nil)
    }
    
    func setupInputComponents(){

        self.view.addSubview(navigationBarSeparatorLine)
        
        //constraints
        navigationBarSeparatorLine.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navigationBarSeparatorLine.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        navigationBarSeparatorLine.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        navigationBarSeparatorLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    
        view.addSubview(containerView)
        // add constraints
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0)
        containerViewBottomAnchor?.isActive  = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 47.5).isActive = true
        
        //send button
        let sendButton = UIButton(type: .custom)
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.layer.backgroundColor = UIColor.appColorDarkGray.cgColor
        sendButton.layer.cornerRadius = 5
        sendButton.layer.masksToBounds = true
   
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        containerView.addSubview(sendButton)
        
        //send button constraints
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //textfield
        containerView.addSubview(inputTextField)
        
        //inputText constraints
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -8).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: sendButton.heightAnchor).isActive = true
        
        //separator line
        let separatorline = UIView()
        separatorline.backgroundColor = UIColor.appColorLineGray
        separatorline.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorline)
        //consttraints
        separatorline.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorline.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorline.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorline.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
  

    @objc func sendMessage(){
        
        if inputTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).count != 0{
            let ref = Database.database().reference().child(Constants.MESSAGES_PATH.rawValue)
            let childRef = ref.childByAutoId()
            let sender = user?.username!
            let values = [Constants.TEXT_KEY.rawValue: inputTextField.text!, Constants.SENDER_KEY.rawValue: sender!]
            childRef.updateChildValues(values) { (error, ref) in
                if error != nil{
                    return
                }
                self.inputTextField.text = nil
                self.inputTextField.endEditing(true)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    private func observeMessages() {
        
        messagesRef.child(Constants.MESSAGES_PATH.rawValue).observe(.childAdded, with: { (snapshot) in
    
            if let dictionary = snapshot.value as? [String: String] {
                print("\(dictionary.debugDescription)")
                var msg = Message()
                msg.sender = dictionary[Constants.SENDER_KEY.rawValue]
                msg.text = dictionary[Constants.TEXT_KEY.rawValue]
                
               self.messages.append(msg)

                DispatchQueue.main.async {
                    guard self.messages.count > 0 else {return}
                    self.collectionView?.reloadData()
                    self.collectionView?.scrollToItem(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
                }

            }
        }, withCancel: nil)
    }
}

// MARK: - Extension
extension ChatRoomViewController{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if inputTextField.isEditing {
            inputTextField.endEditing(true) // removes keyboard on item click
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
        if let text = messages[indexPath.item].text {
            height = estimatedFrameForText(text: text).height
        }
        // get estimated height
        return CGSize(width: view.frame.width, height: height + 45)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessagesViewCell
        
        let message = messages[indexPath.item]
        
        
        cell.messageTextView.text = message.text
        if let msgTxt = messages[indexPath.item].text {
            
            if message.sender == self.user?.username!{
                
                cell.userTextLabel.text = "You"
                cell.setIncomingMessages(text: msgTxt, deviceWidth: view.frame.width)
                
            } else {
                cell.userTextLabel.text = message.sender
                cell.setOutgoingMessages(text: msgTxt, deviceWidth: view.frame.width)            
            }
            
        }
        
        return cell
    }
}
