//
//  UITableView+Extension.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 11/01/22.
//

import UIKit

extension UITableView {
    func setEmptyView(title: String?, message: String?, image: UIImage?) {
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 18.0)
        messageLabel.textColor = UIColor.darkGray
        messageLabel.font = UIFont.systemFont(ofSize: 19.0)
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        let emptyImageView = UIImageView(image: image)
        emptyImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        emptyImageView.contentMode = .scaleAspectFit
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let containerStack = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, messageLabel])
        
        
        containerStack.alignment = .center
        containerStack.axis = .vertical
        containerStack.distribution = .fill
        containerStack.spacing = 20
        
        if let _ = image {
            emptyImageView.isHidden = false
        } else {
            emptyImageView.isHidden = true
        }
        
        if let _ = title {
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
        
        if let _ = message {
            messageLabel.isHidden = false
        } else {
            messageLabel.isHidden = true
        }
        
        let containerView = UIView()
        containerView.addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        containerStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        containerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        
        self.backgroundView = containerView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
