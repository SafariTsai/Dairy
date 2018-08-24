//
//  SecTableViewCell.swift
//  Dairy
//
//  Created by SAI on 2018/08/24.
//  Copyright © 2018 SAI. All rights reserved.
//

import UIKit

class SecTableViewCell: UITableViewCell {

	@IBOutlet weak var img: UIImageView!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
