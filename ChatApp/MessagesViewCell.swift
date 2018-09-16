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
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    let chatBubbleContainer: UIView = {
        let view = UIView()
    // view.backgroundColor = .red
        //view.backgroundColor = UIColor(red: 136/255, green: 227/255, blue: 6/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let userTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
    //    label.backgroundColor = .blue
        return label
    }()
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
      //  imageView.contentMode = .center
        imageView.backgroundColor = .clear
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
        addSubview(chatBubbleContainer)
        addSubview(bubbleImageView)
        addSubview(userTextLabel)
        addSubview(messageTextView)
                        //chatBubbleContainer.addSubview(bubbleImageView)
        

        
//        chatBubbleContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        chatBubbleContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
//
//
//
//        chatBubbleWidthAnchor = chatBubbleContainer.widthAnchor.constraint(equalToConstant: 0)
//        chatBubbleWidthAnchor?.isActive = true
        
        
        
        
//        let imageName: String = isCurrentUser ? "chat_bubble_user" : "chat_bubble"
//        let topInset: CGFloat = isCurrentUser ? 26 : 7
//        let bottonInset: CGFloat = isCurrentUser ? 7 : 27
//        userTextLabel.textAlignment = isCurrentUser ? .right: .left
        
        //bubbleImageView.image = UIImage(named: imageName)?.resizableImage(withCapInsets: UIEdgeInsets.init(top: topInset, left: 13, bottom: bottonInset, right: 13))
//        bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
//        chatBubbleContainer.addSubview(bubbleImageView)
//
//        bubbleImageView.leftAnchor.constraint(equalTo: chatBubbleContainer.leftAnchor).isActive = true
//        bubbleImageView.topAnchor.constraint(equalTo: chatBubbleContainer.topAnchor).isActive = true
//        bubbleImageView.rightAnchor.constraint(equalTo: chatBubbleContainer.rightAnchor).isActive = true
//        bubbleImageView.bottomAnchor.constraint(equalTo: chatBubbleContainer.bottomAnchor).isActive = true
//
//
//        //usertextLabel constraints
//        userTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
//        userTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        userTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
//        userTextLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//
//        //constraints
//        //messageTextView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        messageTextView.topAnchor.constraint(equalTo: chatBubbleContainer.topAnchor).isActive = true
//        messageTextView.bottomAnchor.constraint(equalTo: chatBubbleContainer.bottomAnchor).isActive = true
//
//        messageLeftViewAnchor = messageTextView.leftAnchor.constraint(equalTo: chatBubbleContainer.leftAnchor)
//        messageLeftViewAnchor?.isActive = true
//        messageRightViewAnchor = messageTextView.rightAnchor.constraint(equalTo: chatBubbleContainer.rightAnchor, constant: -5)
//        messageRightViewAnchor?.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
//        messageTextView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        messageTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
//        messageTextView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        messageTextView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
//        userTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        userTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        userTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        userTextLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        bubbleImageView.leftAnchor.constraint(equalTo: chatBubbleContainer.leftAnchor).isActive = true
        bubbleImageView.rightAnchor.constraint(equalTo: chatBubbleContainer.rightAnchor).isActive = true
        bubbleImageView.topAnchor.constraint(equalTo: chatBubbleContainer.topAnchor).isActive = true
        bubbleImageView.bottomAnchor.constraint(equalTo: chatBubbleContainer.bottomAnchor).isActive = true
    }
    func setOutgoingMessages(text: String, deviceWidth: CGFloat) {
        let _frame = CGRect(x: 0, y: 0, width: estimatedFrameForText(text: text).width + 16, height: estimatedFrameForText(text: text).height + 20)
        
        messageTextView.frame = CGRect(x: 13, y: 0, width: _frame.width, height: _frame.height)
        
        userTextLabel.frame = CGRect(x: 14, y: _frame.maxY + 5, width: deviceWidth - 28, height: 20)
        
        chatBubbleContainer.frame = CGRect(x: 7, y: 0, width: _frame.width, height: _frame.height)
        
        bubbleImageView.frame = chatBubbleContainer.frame
        userTextLabel.textAlignment = .left
 
        bubbleImageView.image = UIImage(named: "chat_bubble")?
            .resizableImage(withCapInsets: UIEdgeInsets.init(top: 7, left: 13, bottom: 26, right: 13))
        
    }
    func setIncomingMessages(text: String, deviceWidth: CGFloat){
        let _frame = CGRect(x: 0, y: 0, width: estimatedFrameForText(text: text).width + 12, height: estimatedFrameForText(text: text).height + 20)
        messageTextView.frame = CGRect(x: deviceWidth - _frame.width - 13,
                                       y: 0,
                                       width: _frame.width,
                                       height: _frame.height)
        
        userTextLabel.frame = CGRect(x: 0,
                                     y: _frame.maxY + 5,
                                     width: deviceWidth - 14,
                                     height: 20)
        
        chatBubbleContainer.frame = CGRect(x: deviceWidth - _frame.width - 14, y: 0,
                                           width: _frame.width + 7, height: _frame.height)
        
        bubbleImageView.frame = chatBubbleContainer.frame
        userTextLabel.textAlignment = .right

        bubbleImageView.image = UIImage(named: "chat_bubble_user")?
            .resizableImage(withCapInsets: UIEdgeInsets.init(top: 7, left: 13, bottom: 26, right: 13))
    }
   
    
    private func estimatedFrameForText(text: String) -> CGRect{
        
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)],
                                                   context: NSStringDrawingContext())
    }
    
    
}
