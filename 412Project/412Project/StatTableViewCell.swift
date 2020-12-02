//
//  StatTableViewCell.swift
//  412Project
//
//  Created by Marco Esquivel on 12/1/20.
//

import UIKit

class StatTableViewCell: UITableViewCell {

    @IBOutlet weak var IcuLabel: UILabel!
    @IBOutlet weak var hospitalLabel: UILabel!
    @IBOutlet weak var negativeLabel: UILabel!
    @IBOutlet weak var postiveLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
