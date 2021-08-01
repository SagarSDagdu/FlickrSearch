//
//  PhotosViewController.swift
//  FlickrSearch
//
//  Created by Sagar Dagdu on 01/08/21.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var emptyStateView: UIView!
    
    lazy private var viewModel: PhotosListViewModel = FlickrFactory.shared.photoListViewModel
    
    lazy var columnLayout: ColumnFlowLayout = {
        .init(
            cellsPerRow: 3,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: .init(top: 10, left: 10, bottom: 10, right: 10)
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        searchBar.placeholder = "Search for images"
        title = "Flickr Search"
        searchBar.delegate = self
        
        emptyStateView.isHidden = false
        loadingView.isHidden = true
        photoCollectionView.isHidden = true
    }
    
    // MARK:- Private
    
    private func configureCollectionView() {
        photoCollectionView.register(UINib(nibName: String(describing: PhotoCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: PhotoCollectionViewCell.self))
        photoCollectionView.collectionViewLayout = columnLayout
        photoCollectionView.contentInsetAdjustmentBehavior = .always
        photoCollectionView.dataSource = self
    }
    
    private func prefetchIfNeeded(_ currentIndexPath: IndexPath) {
        if !viewModel.isCurrentlyFetching && currentIndexPath.row == viewModel.photos.count - 5 {
            viewModel.fetchNextImages { [weak self] in
                self?.photoCollectionView.reloadData()
            }
        }
    }
    
    private func refreshViewState() {
        let isDataEmpty = self.viewModel.photos.isEmpty
        self.emptyStateView.isHidden = !isDataEmpty
        self.photoCollectionView.isHidden = isDataEmpty
    }
}

extension PhotosViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        viewModel.resetSearch()
        photoCollectionView.reloadData()
        
        guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespaces), !searchText.isEmpty else {
            print("Invalid search")
            return
        }
        
        viewModel.currentSearchString = searchText
        emptyStateView.isHidden = true
        loadingView.isHidden = false
        photoCollectionView.isHidden = true
        
        viewModel.fetchNextImages { [weak self] in
            self?.loadingView.isHidden = true
            self?.refreshViewState()
            self?.photoCollectionView.reloadData()
        }
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = viewModel.photos[indexPath.row]
        let cell = photoCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoCollectionViewCell.self), for: indexPath) as! PhotoCollectionViewCell
        
        let url = URL(string: photo.flickrImageUrl!)!
        
        cell.imageView.loadImage(at: url, placeholer: UIImage(systemName: "photo"))
        cell.onReuse = { [weak cell] in
            cell?.imageView.cancelImageLoad()
        }
        
        prefetchIfNeeded(indexPath)
        return cell
    }
}

extension UIImageView {
    func loadImage(at url: URL, placeholer: UIImage? = nil) {
        image = placeholer
        FlickrFactory.shared.uiImageLoader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        FlickrFactory.shared.uiImageLoader.cancel(for: self)
    }
}
