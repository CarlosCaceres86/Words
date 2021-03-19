//
//  WordTableViewCell.swift
//  Words
//
//  Created by Carlos Cáceres González on 19/03/2021.
//

import UIKit

class WordTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!

    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: Functions
    // MARK: Internal
    func setCell(word: WordCounted) {
        DispatchQueue.main.async {
            self.wordLabel.text = word.word
            self.countLabel.text = "\(word.count)"
        }
    }

} // WordTableViewCell
