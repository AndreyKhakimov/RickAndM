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
        tableview.register(CharacterTableViewCell.self, forCellReuseIdentifier: "CharacterCell")
        return tableview
    }()
    
    private let charactersNetworkManager = CharactersNetworkManager()
    private var characters = [Character]()
    private var charactersResponse: CharactersResponse?
    private var isPaginating = false
    private var paginationDataTask: URLSessionDataTask?
    private var currentPage = 1
    private var pagesCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(charactersTableView)
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.prefetchDataSource = self
        setupNavigationBar()
        setupTableView()
        fetchDataScrolling(with: 1)
    }
    
    // MARK: - Fetching Data
    private func fetchDataScrolling(with pageNumber: Int) {
        isPaginating = true
        paginationDataTask?.cancel()
        guard pageNumber <= pagesCount else { return }
        paginationDataTask = charactersNetworkManager.getCharactersByPage(
            number: pageNumber,
            completion: { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(let charactersResponse):
                        self.pagesCount = charactersResponse.info.pages
                        self.currentPage = pageNumber
                        self.charactersResponse = charactersResponse
                        if pageNumber > 1 {
                            self.characters.append(contentsOf: charactersResponse.results)
                        } else {
                            self.characters = charactersResponse.results
                        }
                        self.charactersTableView.reloadData()
                    case .failure(let error):
                        if case .cancelled = error { break }
                        self.showAlert(title: error.title, message: error.description)
                    }
                    self.isPaginating = false
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
    
}

// MARK: - TableView Datasource Methods
extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
        let character = characters[indexPath.row]
        let imageURL = URL(string: character.image)
        cell.configure(image: imageURL, name: character.name, info: character.smallDescription)
        return cell
    }
    
    
}

// MARK: - TableView Delegate Methods
extension CharactersListViewController: UITableViewDelegate, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let characterInfoVC = CharacterInfoViewController()
        characterInfoVC.id = character.id
        navigationController?.pushViewController(characterInfoVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if !isPaginating, indexPaths.map({ $0.row }).max() == characters.count - 1 {
            fetchDataScrolling(with: currentPage + 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        if let paginationDataTask = paginationDataTask,
           indexPaths.map({ $0.row }).max() == characters.count - 1
        {
            paginationDataTask.cancel()
            isPaginating = false
        }
    }
}
