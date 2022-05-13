//
//  VideoCollectionViewCell.swift
//  QuickstartApp
//
//  Created by 김가람 on 2021/03/01.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper

class VideoCollectionViewCell: UICollectionViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var titleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var moreViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    
    var isPlaying = false
    var data: VideoItem? {
        didSet {
            if let data = self.data {
                self.titleLabel.text = data.snippet?.title ?? ""
                
                self.descriptionLabel.text = data.snippet?.snippetDescription ?? ""
                
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.timeZone = TimeZone(identifier:"GMT")
                dateFormatterPrint.dateFormat = "yy/MM/dd"
                let date = data.snippet?.publishedAt ?? Date()
                let datestring = dateFormatterPrint.string(from: date)
                self.dateLable.text = datestring
                
                let thumbnail = data.snippet?.thumbnails
                self.thumbnailView.sd_setImage(with: URL(string: thumbnail?.default?.url ?? ""), placeholderImage: nil)
                
                // 이미지 비율 조정
                let screenSize: CGRect = UIScreen.main.bounds
                if let image = self.thumbnailView.image {
                    let ratio = image.size.width / image.size.height
                    if screenSize.width > screenSize.height {
                        let newHeight = screenSize.width / ratio
                        self.imageViewHeight.constant = newHeight
                    }
                    else{
                    }
                }
            }
        }
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBAction func moreTouchUpInside(_ sender: Any) {
        if (self.descriptionLabel.numberOfLines == 2) {
            self.descriptionLabel.numberOfLines = 0;
            self.descriptionLabel.sizeToFit()
            if self.contentViewHeight.constant < self.descriptionLabel.frame.size.height {
                self.contentViewHeight.constant = self.descriptionLabel.frame.size.height
            }
            
            self.moreButton.setTitle("접기", for: .normal)
        }
        else {
            self.descriptionLabel.numberOfLines = 2;
            self.contentViewHeight.constant = 50
            
            self.moreButton.setTitle("더보기", for: .normal)
        }
    }
    
    @IBAction func playTouchUpInside(_ sender: Any) {
        if isPlaying {
            self.stopPlayer()
        }
        else if let videoID = self.data?.id?.videoID {
            playerView.load(withVideoId: videoID)
            playerView.playVideo()
        }
    }
    
    func stopPlayer() {
        playerView.stopVideo()
    }
}

// MARK: YTPlayerViewDelegate
extension VideoCollectionViewCell: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case YTPlayerState.playing:
            isPlaying = true
            print("playState : playing")
        case YTPlayerState.paused:
            isPlaying = false
            print("playState : paused")
        case YTPlayerState.ended:
            isPlaying = false
            print("playState : ended")
        default:
            isPlaying = false
            print("playState : " + String(describing: state.rawValue))
        }
    }
}
