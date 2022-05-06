//
//  CharacterTableViewCell.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 02.05.2022.
//

import UIKit
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    var characterCellViewModel: CharacterCellViewModelProtocol! {
        didSet {
            if let image = characterCellViewModel.characterImage {
                characterImageView.kf.setImage(with: URL(string: image))
            } else {
                characterImageView.image = UIImage(systemName: "photo.artframe")
            }
            characterNameLabel.text = characterCellViewModel.characterName
            characterInfoLabel.text = characterCellViewModel.characterSmallDescription
        }
    }
    
    static let identifier = "CharacterCell"
    
    private let characterImageView: UIImageView = {
        let imageView = RoundedImageView(frame: CGRect())
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight: .medium)
        return label
    }()
    
    private let characterInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        characterInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(characterNameLabel)
        contentView.addSubview(characterInfoLabel)
        
        NSLayoutConstraint.activate([
            characterImageView.widthAnchor.constraint(equalToConstant: 44),
            characterImageView.heightAnchor.constraint(equalToConstant: 44),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            
            characterNameLabel.leftAnchor.constraint(equalTo: characterImageView.rightAnchor, constant: 16),
            characterNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            characterNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 8),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            characterInfoLabel.leftAnchor.constraint(equalTo: characterImageView.rightAnchor, constant: 16),
            characterInfoLabel.topAnchor.constraint(equalTo: characterNameLabel.bottomAnchor, constant: 4),
            characterInfoLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 8),
            characterInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    //    func configure(image: URL?, name: String, info: String) {
    //        if let image = image {
    //            characterImageView.kf.setImage(with: image)
    //        } else {
    //            characterImageView.image = UIImage(systemName: "photo.artframe")
    //        }
    //        characterNameLabel.text = name
    //        characterInfoLabel.text = info
    //    }
    
}
