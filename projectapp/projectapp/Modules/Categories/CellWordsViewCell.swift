//
//  CellWordsViewCell.swift
//  project
//
//  Created by Rafael Shamsutdinov on 07.07.2022.
import UIKit

class CellWordsViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wordsAmount: UILabel!
    @IBOutlet weak var checkLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        makeShadow(cornerRadius: 22)
    }
    var isInEditingMode: Bool = false {
        didSet{
            checkLabel.isHidden = !isInEditingMode
        }
    }
    override var isSelected: Bool {
        didSet {
            if isInEditingMode {
                checkLabel.text = isSelected ? "✓" : ""
            }
        }
    }
}

