//
//  MainViewController.swift
//  QuickstartApp
//
//  Created by 김가람 on 2021/03/01.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "VideoCollectionViewCell"

class MainViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var videoViewModel: VideoViewModelProtocol? {
        didSet {
            self.videoViewModel?.videoListDidChange = { [unowned self] viewModel in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoViewModel = VideoViewModel()
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let keyword = searchBar.text {
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionView.ScrollPosition.top, animated: true)
            self.videoViewModel?.keyword = keyword
            self.searchBarCancelButtonClicked(searchBar)
        }
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.videoViewModel?.videoList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCollectionViewCell
        guard let data = self.videoViewModel?.videoList?[indexPath.row] else { return cell }
        guard let snippet = data.snippet else { return cell }
        
        cell.data = data

        cell.stackViewWidth.constant = collectionView.frame.size.width

        cell.setTitle(data.snippet?.title ?? "")
        cell.setDescriptionLabel(data.snippet?.snippetDescription ?? "")
        cell.setPublishedAt(data.snippet?.publishedAt ?? Date())
        cell.setThumbnail(snippet.thumbnails ?? Thumbnails.init(thumbnailsDefault: Default.init(url: "", width: 0, height: 0), high: Default.init(url: "", width: 0, height: 0), medium: Default.init(url: "", width: 0, height: 0)))
        
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if let count = self.videoViewModel?.videoList?.count {
            if (indexPath.row == count - 1 ) {
                if (self.videoViewModel?.nextPageToken) != nil {
                    self.videoViewModel?.requestVideoList()
                }
             }
        }
    }

}
