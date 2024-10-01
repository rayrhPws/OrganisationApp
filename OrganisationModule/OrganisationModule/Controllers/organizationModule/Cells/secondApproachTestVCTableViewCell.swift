//
//  secondApproachTestVCTableViewCell.swift
//  OrganisationModule
//
//  Created by Arif on 19/09/2024.
//

import UIKit
import WebKit
class secondApproachTestVCTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var webkitHeight: NSLayoutConstraint!
    var identifier = "secondApproachTestVCTableViewCell"
    @IBOutlet weak var viewWK: WKWebView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
