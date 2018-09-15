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
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .yellow
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    let chatBubble: UIView = {
        let view = UIView()
      //  view.backgroundColor = .red
        //view.backgroundColor = UIColor(red: 136/255, green: 227/255, blue: 6/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let userTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = .blue
        return label
    }()
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var chatBubbleWidthAnchor: NSLayoutConstraint?
    var chatBubbleRightAnchor: NSLayoutConstraint?
    var chatBubbleLeftAnchor: NSLayoutConstraint?
    var messageLeftViewAnchor: NSLayoutConstraint?
    var messageRightViewAnchor: NSLayoutConstraint?
    
    var isCurrentUser: Bool = false
    var usersName: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chatBubble)
        addSubview(userTextLabel)
        addSubview(messageTextView)

        chatBubbleRightAnchor = chatBubble.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
        chatBubbleRightAnchor?.isActive = isCurrentUser
        
        chatBubble.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        chatBubbleLeftAnchor = chatBubble.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5)
        chatBubbleLeftAnchor?.isActive = !isCurrentUser
        
        chatBubbleWidthAnchor = chatBubble.widthAnchor.constraint(equalToConstant: 200)
        chatBubbleWidthAnchor?.isActive = true
        
        chatBubble.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
        
//        let imageName: String = isCurrentUser ? "chat_bubble_user" : "chat_bubble"
//        let topInset: CGFloat = isCurrentUser ? 26 : 7
//        let bottonInset: CGFloat = isCurrentUser ? 7 : 27
//        userTextLabel.textAlignment = isCurrentUser ? .right: .left
        
        //bubbleImageView.image = UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets.init(top: topInset, left: 13, bottom: bottonInset, right: 13))
        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
        chatBubble.addSubview(bubbleImageView)
        
        bubbleImageView.leftAnchor.constraint(equalTo: chatBubble.leftAnchor).isActive = true
        bubbleImageView.topAnchor.constraint(equalTo: chatBubble.topAnchor).isActive = true
        bubbleImageView.rightAnchor.constraint(equalTo: chatBubble.rightAnchor).isActive = true
        bubbleImageView.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor).isActive = true
        
        
        //usertextLabel constraints
        userTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        userTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        userTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        userTextLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //constraints
        //messageTextView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageTextView.topAnchor.constraint(equalTo: chatBubble.topAnchor).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: chatBubble.bottomAnchor).isActive = true
        
        messageLeftViewAnchor = messageTextView.leftAnchor.constraint(equalTo: chatBubble.leftAnchor)
        messageLeftViewAnchor?.isActive = true
        messageRightViewAnchor = messageTextView.rightAnchor.constraint(equalTo: chatBubble.rightAnchor)
        messageRightViewAnchor?.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
