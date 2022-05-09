//
//  CharactersListViewModel.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 02.05.2022.
//

import Foundation

protocol CharactersListViewModelProtocol: AnyObject {
    var characters: [Character] { get }
    var isPaginating: Bool { get set }
    var paginationDataTask: URLSessionDataTask? { get }
    var currentPage: Int { get set }
    var pagesCount: Int { get }
    var viewModelDidChange: (() -> Void)? { get set }
    
    func fetchCharacters(with pageNumber: Int, completion: @escaping() -> Void)
    func numberOfRows() -> Int
    func characterCellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol
    func viewDidLoad()
    func didScrollToPageEnd()
    func cancelFetchingData()
}

class CharactersListViewModel: CharactersListViewModelProtocol {
    
    var characters = [Character]()
    
    private let charactersNetworkManager = CharactersNetworkManager()
    var isPaginating = false
    var paginationDataTask: URLSessionDataTask?
    var currentPage = 1
    var pagesCount = 1
    var viewModelDidChange: (() -> Void)?
    
    func viewDidLoad() {
        fetchCharacters(with: currentPage) {}
    }
    
    
    func fetchCharacters(with pageNumber: Int, completion: @escaping() -> Void) {
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
                        if pageNumber > 1 {
                            self.characters.append(contentsOf: charactersResponse.results)
                        } else {
                            self.characters = charactersResponse.results
                        }
                        completion()
                    case .failure(let error):
                        if case .cancelled = error { break }
                        // TODO: - Fix showing alert issue
//                        self.showAlert(title: error.title, message: error.description)
                    }
                    self.isPaginating = false
                    self.viewModelDidChange?()
                }
            }
        )
    }
    
    func didScrollToPageEnd() {
        fetchCharacters(with: currentPage + 1) { [weak self] in
            self?.currentPage += 1
        }
    }
    
    func cancelFetchingData() {
        paginationDataTask?.cancel()
        isPaginating = false
    }
    
    func numberOfRows() -> Int {
        characters.count
    }
    
    func characterCellViewModel(at indexPath: IndexPath) -> CharacterCellViewModelProtocol {
        CharacterCellViewModel(character: characters[indexPath.row])
    }
    
}


