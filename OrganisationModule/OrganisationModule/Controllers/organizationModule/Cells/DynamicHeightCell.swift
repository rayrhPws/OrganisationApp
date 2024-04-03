//
//  DynamicHeightCell.swift
//  OrganisationModule
//
//  Created by Arif ww on 02/04/2024.
//

import UIKit

class DynamicHeightCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblTitle.adjustsFontForContentSizeCategory = true
        lblTitle.font = UIFont.preferredFont(forTextStyle: .body)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
