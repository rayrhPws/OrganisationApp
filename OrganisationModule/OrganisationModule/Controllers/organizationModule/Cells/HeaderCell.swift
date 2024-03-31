//
//  HeaderCell.swift
//  OrganisationModule
//
//  Created by Arif ww on 28/03/2024.
//

import UIKit

class HeaderCell: UITableViewCell {
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
