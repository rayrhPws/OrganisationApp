//
//  DynamicHeightCollCell.swift
//  OrganisationModule
//
//  Created by Arif on 21/10/2024.
//

import UIKit

class DynamicHeightCollCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblTitle.adjustsFontForContentSizeCategory = true
        lblTitle.font = UIFont.preferredFont(forTextStyle: .body)
    }

}
