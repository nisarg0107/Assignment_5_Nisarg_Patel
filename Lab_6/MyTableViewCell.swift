//
//  MyTableViewCell.swift
//  Lab_6
//
//  Created by user238292 on 2/19/24.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
