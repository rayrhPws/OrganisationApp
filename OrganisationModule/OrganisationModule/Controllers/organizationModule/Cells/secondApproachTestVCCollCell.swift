//
//  secondApproachTestVCCollCell.swift
//  OrganisationModule
//
//  Created by Arif on 21/10/2024.
//

import UIKit
import WebKit

class secondApproachTestVCCollCell: UICollectionViewCell {
    var identifier = "secondApproachTestVCCollCell"
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var webkitHeight: NSLayoutConstraint!
    @IBOutlet weak var viewWK: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
