//
//  MainViewController.swift
//  QuickstartApp
//
//  Created by 김가람 on 2021/03/01.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "VideoCollectionViewCell"

class MainViewController: BaseViewController {
    
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
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
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
            if ((self.videoViewModel?.videoList) != nil) {
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionView.ScrollPosition.top, animated: true)
            }
            self.videoViewModel?.keyword = keyword
            self.searchBarCancelButtonClicked(searchBar)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
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
        guard data.snippet != nil else { return cell }
        
        cell.data = data

        cell.stackViewWidth.constant = collectionView.frame.size.width        
        
        return cell
    }
}

// MARK: UIScrollViewDelegate
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let cell = self.collectionView.visibleCells.last {
            let indexPath = self.collectionView.indexPath(for: cell)
            if (indexPath?.row == (self.videoViewModel?.videoList?.count ?? 0) - 1) {
                if (self.videoViewModel?.nextPageToken) != nil {
                    self.videoViewModel?.requestVideoList()
                }
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let cells:[VideoCollectionViewCell] = self.collectionView.visibleCells as? [VideoCollectionViewCell] else {
            return
        }
        for cell in cells {
            if cell.isPlaying {
                cell.stopPlayer()
            }
        }
    }
}
