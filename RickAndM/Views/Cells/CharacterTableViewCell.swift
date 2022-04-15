//
//  CharacterTableViewCell.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 14.04.2022.
//

import UIKit
import Kingfisher


class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterInfoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(image: URL?, name: String, info: String) {
        if let image = image {
            characterImageView.kf.setImage(with: image)
        } else {
            characterImageView.image = UIImage(systemName: "photo.artframe")
        }
        characterNameLabel.text = name
        characterInfoLabel.text = info
    }
    
}