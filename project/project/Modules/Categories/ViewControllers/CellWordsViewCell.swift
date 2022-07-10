//
//  CellWordsViewCell.swift
//  project
//
//  Created by Rafael Shamsutdinov on 07.07.2022.
import UIKit

class CellWordsViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wordsAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeShadow(cornerRadius: 22)
    }
}
