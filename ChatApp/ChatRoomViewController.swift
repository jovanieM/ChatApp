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
    
   
    
    let containerView:UIView = {
        let uiView: UIView = UIView()
        uiView.backgroundColor = .white
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
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
        button.translatesAutoresizingMaskIntoConstraints = false
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
    

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.background = UIImage(named: "textfield_bg")
        textField.setLeftPaddingPoints(10)
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let safeAreaInsetCoverView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .blue
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    let cellId = "cellId"
    
    var safeAreaBottomInset: CGFloat?
    var containerViewBottomAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "Chat app"
        navigationController?.setToolbarHidden(false, animated: false)
        navigationController?.navigationBar.isTranslucent = false


        
        let rightBarButton = UIBarButtonItem(customView: logoutBtn)
        navigationItem.rightBarButtonItems = [rightBarButton]
        
        setupInputComponents()
        collectionView?.contentInset = UIEdgeInsets.init(top: 8, left: 0, bottom: 47.5, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
        collectionView?.register(MessagesViewCell.self, forCellWithReuseIdentifier: cellId)
    

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardObserver), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardObserver), name: NSNotification.Name.UIKeyboardWillShow,object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardObserver), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if safeAreaBottomInset == nil {
            if #available(iOS 11.0, *) {
                print("safeAreaInsets \(view.safeAreaInsets)")
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
    
    override func viewDidAppear(_ animated: Bool) {
        observeMessages()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardObserver(noticifation: Notification) {
    
        if let userInfo = noticifation.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            
            let isKeyboardShowing = noticifation.name == NSNotification.Name.UIKeyboardWillShow
            
            containerViewBottomAnchor?.constant = isKeyboardShowing ? (-keyboardFrame!.height + safeAreaBottomInset!) : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (comleted) in
                if isKeyboardShowing {
                    let indexPath = IndexPath(item: self.messages.count
                         - 1, section: 0)
                    self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessagesViewCell
        
        let message = messages[indexPath.item]
        cell.messageTextView.text = message.text
        cell.userTextLabel.text = message.sender
        let test = messages.count % 2
        if  test == 0{
            cell.chatBubbleRightAnchor?.isActive = true
            cell.chatBubbleLeftAnchor?.isActive = false
           // cell.messageTextView.backgroundColor = .black
            cell.messageLeftViewAnchor?.constant = 0
            cell.messageRightViewAnchor?.constant = -5
           
            cell.bubbleImageView.image = UIImage(named: "chat_bubble_user")?
            .resizableImage(withCapInsets: UIEdgeInsets.init(top: 7, left: 13, bottom: 26, right: 13))
        } else {
            cell.chatBubbleRightAnchor?.isActive = false
            cell.chatBubbleLeftAnchor?.isActive = true
//            cell.bubbleImageView.image = UIImage(named: "chat_bubble")?
//                .resizableImage(withCapInsets: UIEdgeInsets.init(top: 7, left: 13, bottom: 26, right: 13))
        }
        
        cell.chatBubbleWidthAnchor?.constant = estimatedFrameForText(text: message.text!).width + 32
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if inputTextField.isEditing {
            inputTextField.endEditing(true) // removes keyboard on item click
        }
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
    
        view.addSubview(containerView)
        // add constraints
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0)
        containerViewBottomAnchor?.isActive  = true
        containerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 47.5).isActive = true
        
        
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
        separatorline.backgroundColor = .gray
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
            let ref = Database.database().reference().child("messages")
            let childRef = ref.childByAutoId()
            let values = ["text": inputTextField.text!, "sender": "midoriya"]
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

                DispatchQueue.main.async {
                    print("messages count \(self.messages.count)")
                    self.collectionView?.reloadData()
                    self.collectionView?.scrollToItem(at: IndexPath(row: self.messages.count - 1, section: 0), at: .bottom, animated: true)
                }

            }
        }, withCancel: nil)
    }
}
