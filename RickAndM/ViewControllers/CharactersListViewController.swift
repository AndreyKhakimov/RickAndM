//
//  ViewController.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 14.04.2022.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    private let charactersTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "Character")
        return tableview
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 30, width: 104, height: 24))
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private let charactersNetworkManager = CharactersNetworkManager()
    private var characters = [Character]()
    private var charactersResponse: CharactersResponse?
    
    private var currentPage = 1 {
        didSet {
            updateBarButtonItems()
        }
    }
    private var pagesCount = 0 {
        didSet {
            updateBarButtonItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(charactersTableView)
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        setupNavigationBar()
        setupTableView()
        updateBarButtonItems()
        fetchData(with: 1)
    }
    
    @objc private func updatePageData(_ sender: UIBarButtonItem) {
        currentPage += sender.tag == 1 ? 1 : -1
        fetchData(with: currentPage)
    }
    
    // MARK: - Fetching Data
    private func fetchData(with pageNumber: Int) {
        charactersNetworkManager.getCharactersByPage(
            number: pageNumber,
            completion: { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    switch result {
                    case .success(let charactersResponse):
                        self.pagesCount = charactersResponse.info.pages
                        self.charactersResponse = charactersResponse
                        self.characters = charactersResponse.results
                        self.charactersTableView.reloadData()
                        self.updateTitle()
                    case .failure(let error):
                        self.showAlert(title: error.title, message: error.description)
                    }
                }
            }
        )
    }
    
    // MARK: - Setup Views
    private func setupNavigationBar() {
        title = "CharactersList"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(updatePageData)
        )
        
        navigationItem.rightBarButtonItem?.tag = 1
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Prev",
            style: .plain,
            target: self,
            action: #selector(updatePageData)
        )
        navigationItem.titleView = titleLabel
    }
    
    private func setupTableView() {
        charactersTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            charactersTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            charactersTableView.topAnchor.constraint(equalTo: view.topAnchor),
            charactersTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            charactersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        charactersTableView.rowHeight = 60
    }
    
    private func updateTitle() {
        titleLabel.text = "Page \(currentPage)/\(pagesCount)"
    }
    
    private func updateBarButtonItems() {
        if currentPage <= 1 {
            navigationItem.leftBarButtonItem?.isEnabled = false
        } else {
            navigationItem.leftBarButtonItem?.isEnabled = true
        }
        if currentPage == pagesCount {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
}

// MARK: - TableView Datasource Methods
extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Character", for: indexPath) as! CharacterTableViewCell
        let character = characters[indexPath.row]
        let imageURL = URL(string: character.image)
        cell.configure(image: imageURL, name: character.name, info: character.smallDescription)
        return cell
    }
    
    
}

// MARK: - TableView Delegate Methods
extension CharactersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let characterInfoVC = CharacterInfoViewController()
        characterInfoVC.id = character.id
        navigationController?.pushViewController(characterInfoVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
