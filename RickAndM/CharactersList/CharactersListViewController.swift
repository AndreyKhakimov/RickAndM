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
    
    private var viewModel: CharactersListViewModelProtocol! {
        didSet {
                charactersTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(charactersTableView)
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.prefetchDataSource = self
        setupNavigationBar()
        setupTableView()
//        fetchDataScrolling(with: 1)
        viewModel = CharactersListViewModel()
        viewModel.viewModelDidChange = { [weak self] _ in
            self?.charactersTableView.reloadData()
        }
        viewModel.viewDidLoad()
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
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
        cell.characterCellViewModel = viewModel.characterCellViewModel(at: indexPath)
        
        return cell
    }
    
    
}

// MARK: - TableView Delegate Methods
extension CharactersListViewController: UITableViewDelegate, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        let characterInfoVC = CharacterInfoViewController()
        characterInfoVC.id = character.id
        navigationController?.pushViewController(characterInfoVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if !viewModel.isPaginating, indexPaths.map({ $0.row }).max() == viewModel.characters.count - 1 {
            viewModel.didScrollToPageEnd()
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//        if let paginationDataTask = paginationDataTask,
//           indexPaths.map({ $0.row }).max() == characters.count - 1
//        {
//            paginationDataTask.cancel()
//            isPaginating = false
//        }
    }
}
