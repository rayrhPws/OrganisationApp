//
//  HeaderCollCell.swift
//  OrganisationModule
//
//  Created by Arif on 21/10/2024.
//

import UIKit

class HeaderCollCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblTitle.adjustsFontForContentSizeCategory = true
        let bodyFont = UIFont.preferredFont(forTextStyle: .body)
        let boldBodyFont = UIFont.boldSystemFont(ofSize: bodyFont.pointSize)
        lblTitle.font = boldBodyFont
    }

}
