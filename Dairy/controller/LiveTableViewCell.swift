//
//  LiveTableViewCell.swift
//  Dairy
//
//  Created by SAI on 2018/08/22.
//  Copyright © 2018 SAI. All rights reserved.
//

import UIKit

class LiveTableViewCell: UITableViewCell {

	
	@IBOutlet weak var imgOverview: UIImageView!
	@IBOutlet weak var labelOLUser: UILabel!
	@IBOutlet weak var LabelLocation: UILabel!
	@IBOutlet weak var labelNick: UILabel!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 
}
