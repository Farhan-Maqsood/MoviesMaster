//
//  EmptyTableViewCell.swift
//  MovieMaster
//
//  Created by Farhan Maqsood on 10/04/2023.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    @IBOutlet weak var lblEmptyText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config()
    {
        lblEmptyText.text = "Enter text in search field."
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
