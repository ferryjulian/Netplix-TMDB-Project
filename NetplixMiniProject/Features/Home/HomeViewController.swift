//
//  HomeViewController.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import UIKit
import SnapKit
import RxSwift

class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    lazy var collectionViewMovie: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collection)
        
        collection.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        return collection
    }()
    
    // MARK: - Variables
    private let searchController = UISearchController()
    private let disposeBag = DisposeBag()
    private var homeVM: HomeViewModel!
    private var movies = [Movie]()
    private var curentPage = 1
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        configureView()
        fetchingData()
    }
    
    // MARK: - Configure View
    private func configureView() {
        title = "Netplix"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        homeVM = HomeViewModel()
        homeVM.fetchPopularMovies(page: curentPage)
        
        self.collectionViewMovie.delegate = self
        self.collectionViewMovie.dataSource = self
        self.collectionViewMovie.register(cell: HomeMovieCell.self)
    }
    
    // MARK: - Fetching Data
    private func fetchingData() {
        homeVM.popularMovies.subscribe(onNext: { [weak self] state in
            guard let self = self else {return}
            switch state.simplify() {
            case .loading:
                self.showSpinner()
            case .success(let data):
                self.movies.append(contentsOf: data)
                self.collectionViewMovie.reloadData()
                self.hideSpinner()
            case .error(let error):
                self.showGeneralError(message: error.localizedDescription)
                self.hideSpinner()
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
    
}

// MARK: - Configure CollectionView
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(for: indexPath) as HomeMovieCell
        cell.configureView(movie: movies[indexPath.row])
        
        if indexPath.row == movies.count - 1 {
            curentPage += 1
            homeVM.fetchPopularMovies(page: curentPage)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let navigationController = navigationController {
            let vc = DetailViewController()
            vc.movie = self.movies[indexPath.row]
            vc.modalPresentationStyle = .pageSheet
            navigationController.present(vc, animated: true)
        }
    }
}

// MARK: - Configure CollectionViewLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let itemWidth = view.bounds.width / 2
        return CGSize(width: itemWidth - 2 , height: HomeMovieCell.CELL_HEIGHT )
    }
}

// MARK: - Search Result Updating Functions
extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        print(text)
    }
}
