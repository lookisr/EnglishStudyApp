//
//  DictTableViewCell.swift
//  project
//
//  Created by Тимур Хайруллин on 08.07.2022.
//

import UIKit

class DictTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
