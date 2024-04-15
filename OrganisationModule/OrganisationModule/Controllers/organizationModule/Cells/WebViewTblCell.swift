//
//  WebViewTblCell.swift
//  OrganisationModule
//
//  Created by Arif ww on 21/03/2024.
//

import UIKit
import WebKit

class WebViewTblCell: UITableViewCell {
    var identifier = "WebViewTblCell"
    @IBOutlet weak var viewWK: WKWebView!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewWK.scrollView.isScrollEnabled = false
//        self.viewWK.navigationDelegate = self
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
    
}
