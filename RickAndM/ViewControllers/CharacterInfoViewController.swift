//
//  CharacterInfoViewController.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 14.04.2022.
//

import UIKit
import Kingfisher

class CharacterInfoViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var character: Character?
    private let characterNetworkManager = CharactersNetworkManager()
    var id: Int?
    
    private lazy var characterImageView: RoundedImageView = {
        let imageView = RoundedImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(characterImageView)
        setupScrollView()
        setupViews()
        fetchData(with: id ?? 1)
    }
    
    private func fetchData(with id: Int) {
        characterNetworkManager.getCharacter(
            id: id,
            completion: { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let character):
                        self.character = character
                        self.titleLabel.text = character.description
                        self.characterImageView.kf.setImage(with:URL(string: character.image))
                    case .failure(let error):
                        self.showAlert(title: error.title, message: error.description)
                    }
                }
            }
        )
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Character"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        label.setLineHeight(lineHeight: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension CharacterInfoViewController {
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupViews(){
        contentView.addSubview(characterImageView)
        characterImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        characterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contentView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 25).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
    }
}
