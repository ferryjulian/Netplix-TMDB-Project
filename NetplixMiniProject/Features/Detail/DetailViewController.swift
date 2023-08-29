//
//  DetailViewController.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import UIKit
import RxSwift
import Kingfisher

class DetailViewController: UIViewController {
    
    // MARK: - UI Components
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var btnTrailler: UIButton!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVote: UILabel!
    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var viewTblReview: UIView!
    @IBOutlet weak var tblReview: UITableView!
    @IBOutlet weak var imgPoster: UIImageView!
    
    // MARK: - Variables
    private var curentPage = 1
    private let disposeBag = DisposeBag()
    private var movieReview = [MovieReview]()
    private var detailVM: DetailViewModel?
    private var movieVideo: MovieVideo?
    var movie: Movie!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        fetchingData()
    }
    
    // MARK: - Configure Youtube URL
    @IBAction func didTapTrailler(_ sender: Any) {
        if let url = movieVideo?.youtubeURL {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Configure View
    private func configureView() {
        detailVM = DetailViewModel()
        detailVM?.fetchVideosMovie(idMovie: movie.id ?? 0)
        detailVM?.fetchReviewsMovie(idMovie: movie.id ?? 0, page: curentPage)
        
        self.lblOverview.text = movie?.overview
        self.lblVote.text = movie?.voteAveragePercentText
        self.lblTitle.text = movie?.title
        self.imgBackdrop.setImageUrl(urlPath: movie?.backdropURL ?? "")
        self.imgPoster.setImageUrl(urlPath: movie?.posterURL ?? "")
        
        self.tblReview.delegate = self
        self.tblReview.dataSource = self
        self.tblReview.register(cell: DetailMovieCell.self)
    }
    
    // MARK: - Fetching Data
    private func fetchingData() {
        detailVM?.reviewsMovie.subscribe(onNext: { [weak self] state in
            guard let self = self else {return}
            switch state.simplify() {
            case .loading:
                self.actIndicator.start()
            case .success(let data):
                self.movieReview.append(contentsOf: data)
                self.actIndicator.stop()
                self.tblReview.reloadData()
                if data.isEmpty {
                    self.viewTblReview.isHidden = false
                    self.showLottie(name: "empty", view: self.viewTblReview, loop: .loop, speed: 0.5)
                }
            case .error(let error):
                self.showGeneralError(message: error.localizedDescription)
                self.actIndicator.stop()
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        
        detailVM?.videosMovie.subscribe(onNext: { [weak self] state in
            guard let self = self else {return}
            switch state.simplify() {
            case .loading:
                self.actIndicator.start()
            case .success(let data):
                self.actIndicator.stop()
                let _ = data.map({ video in
                    if video.type == "Trailer" {
                        self.movieVideo = video
                    }
                })
            case .error(let error):
                self.showGeneralError(message: error.localizedDescription)
                self.actIndicator.stop()
            default:
                break
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - Configure TableView
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(for: indexPath) as DetailMovieCell
        cell.configureView(review: movieReview[indexPath.row])
        
        if indexPath.row == movieReview.count && indexPath.row < movieReview.count {
            curentPage += 1
            detailVM?.fetchReviewsMovie(idMovie: movie.id ?? 0, page: curentPage)
        }
        
        return cell
    }
}
