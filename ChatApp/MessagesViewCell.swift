//
//  MessagesViewCell.swift
//  ChatApp
//
//  Created by CebuSQA on 07/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class MessagesViewCell: UICollectionViewCell {
    
    let messageTextView : UITextView = {
        let textView = UITextView()
        textView.text = "sample texts"
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    let chatBubble: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor(red: 136/255, green: 227/255, blue: 6/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let userTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Jovanie"
        return label
    }()
    
    var chatBubbleWidthAnchor: NSLayoutConstraint?
    var chatBubbleRightAnchor: NSLayoutConstraint?
    var chatBubbleLeftAnchor: NSLayoutConstraint?
    
    var isCurrentUser: Bool = false
    var usersName: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chatBubble)
        addSubview(userTextLabel)
        addSubview(messageTextView)

        chatBubbleRightAnchor = chatBubble.rightAnchor.constraint(equalTo: self.rightAnchor)
        chatBubbleRightAnchor?.isActive = isCurrentUser
        
        chatBubble.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        chatBubbleLeftAnchor = chatBubble.leftAnchor.constraint(equalTo: self.leftAnchor)
        chatBubbleLeftAnchor?.isActive = !isCurrentUser
        
        chatBubbleWidthAnchor = chatBubble.widthAnchor.constraint(equalToConstant: 200)
        chatBubbleWidthAnchor?.isActive = true
        
        chatBubble.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        let iv  = UIImageView(frame: .zero)
        let imageName: String = isCurrentUser ? "chat_bubble_user" : "chat_bubble"
        let topInset: CGFloat = isCurrentUser ? 26 : 7
        let bottonInset: CGFloat = isCurrentUser ? 7 : 27
        userTextLabel.textAlignment = isCurrentUser ? .right: .left
        
        iv.image = UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets.init(top: topInset, left: 13, bottom: bottonInset, right: 13))
        iv.translatesAutoresizingMaskIntoConstraints = false
        chatBubble.addSubview(iv)
        
        iv.leftAnchor.constraint(equalTo: chatBubble.leftAnchor).isActive = true
        iv.topAnchor.constraint(equalTo: chatBubble.topAnchor).isActive = true
        iv.rightAnchor.constraint(equalTo: chatBubble.rightAnchor).isActive = true
        iv.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor).isActive = true
        
        
        //usertextLabel constraints
        userTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        userTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        userTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        userTextLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //constraints
        //messageTextView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageTextView.leftAnchor.constraint(equalTo: chatBubble.leftAnchor, constant: 8).isActive = true
        messageTextView.topAnchor.constraint(equalTo: chatBubble.topAnchor).isActive = true
        messageTextView.rightAnchor.constraint(equalTo: chatBubble.rightAnchor, constant: -8).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
