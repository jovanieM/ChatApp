//
//  MessagesViewCell.swift
//  ChatApp
//
//  Created by CebuSQA on 07/09/2018.
//  Copyright © 2018 CebuSQA. All rights reserved.
//

import UIKit

class MessagesViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    let messageTextView : UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()
    
    let chatBubbleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let userTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.appColorLightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let bubbleImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var chatBubbleWidthAnchor: NSLayoutConstraint?
    var chatBubbleRightAnchor: NSLayoutConstraint?
    var chatBubbleLeftAnchor: NSLayoutConstraint?
    var messageLeftViewAnchor: NSLayoutConstraint?
    var messageRightViewAnchor: NSLayoutConstraint?
   
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(chatBubbleContainer)
        addSubview(bubbleImageView)
        addSubview(userTextLabel)
        addSubview(messageTextView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI constraints
    func setupViews() {

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
        let _frame = CGRect(x: 0, y: 0, width: estimatedFrameForText(text: text).width + 16, height: estimatedFrameForText(text: text).height + 20)
        
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
        
        let size = CGSize(width: self.frame.width * 0.8, height: 1000)
        print("cell \(size.width)")
        let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)],
                                                   context: NSStringDrawingContext())
    }
    
    
}
