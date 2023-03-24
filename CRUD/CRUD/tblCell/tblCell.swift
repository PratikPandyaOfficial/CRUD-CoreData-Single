//
//  tblCell.swift
//  CRUD
//
//  Created by Pratik Pandya on 25/03/23.
//

import UIKit

class tblCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
