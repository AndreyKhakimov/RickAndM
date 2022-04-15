//
//  CharacterInfoViewController.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 14.04.2022.
//

import UIKit
import Kingfisher

class CharacterInfoViewController: UIViewController {
    
    var id: Int?
    private var character: Character?
    private let characterNetworkManager = SingleCharacterManager()
    
    private lazy var characterImageView: RoundedImageView = {
        let imageView = RoundedImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(characterImageView)
        characterImageViewConstraints()
        fetchData(with: id ?? 0)
    }
    
    private func characterImageViewConstraints() {
        
//        imageView.centerXAnchor.constraint(equalTo: revealingSplashView.centerXAnchor).isActive = true
//        imageView.widthAnchor.constraint(equalTo: revealingSplashView.widthAnchor, multiplier: 0.8).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//
        characterImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        characterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
                        self.characterImageView.kf.setImage(with:URL(string: character.image))
                    case .failure(let error):
                        self.showAlert(title: error.title, message: error.description)
                    }
                }
            }
        )
    }
    
}
