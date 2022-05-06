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
    var viewModel: CharacterInfoViewModelProtocol! {
        didSet {
            titleLabel.text = viewModel.characterDescription
            characterImageView.kf.setImage(with:URL(string: viewModel.characterImage))
        }
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let characterNetworkManager = CharactersNetworkManager()
    private var character: Character?
    
    private lazy var characterImageView: RoundedImageView = {
        let imageView = RoundedImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(characterImageView)
        setupScrollView()
        setupViews()
        fetchData(with: id ?? 1)
//        viewModel = CharacterInfoViewModel(character: <#T##Character#>)
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
    
}
// MARK: - Setup Views
extension CharacterInfoViewController {
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func setupViews(){
        contentView.addSubview(characterImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            characterImageView.widthAnchor.constraint(equalToConstant: 250),
            characterImageView.heightAnchor.constraint(equalToConstant: 250),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            characterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 25),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4)
        ])
    }
}
