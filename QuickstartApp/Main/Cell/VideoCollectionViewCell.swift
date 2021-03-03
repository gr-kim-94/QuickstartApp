//
//  VideoCollectionViewCell.swift
//  QuickstartApp
//
//  Created by 김가람 on 2021/03/01.
//

import UIKit
import SDWebImage

class VideoCollectionViewCell: UICollectionViewCell {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var data: VideoItem?

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
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    func setDescriptionLabel(_ description: String) {
        self.descriptionLabel.text = description
    }
    
    func setPublishedAt(_ publishedAt:Date) {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.timeZone = TimeZone(identifier:"GMT")
        dateFormatterPrint.dateFormat = "yy/MM/dd"

        let datestring = dateFormatterPrint.string(from: publishedAt)
        print(datestring)
        print(publishedAt.description)
        self.dateLable.text = datestring
    }
    
    func setThumbnail(_ thumbnails:Thumbnails) {
        let thumbnail = thumbnails.thumbnailsDefault
        self.thumbnailView.sd_setImage(with: URL(string: thumbnail?.url ?? ""), placeholderImage: nil)
        
        // 이미지 비율 조정
        let screenSize: CGRect = UIScreen.main.bounds
        if let image = self.thumbnailView.image {
            let ratio = image.size.width / image.size.height
            if screenSize.width > screenSize.height {
                let newHeight = screenSize.width / ratio
                self.imageViewHeight.constant = newHeight
            }
            else{
                //                let newWidth = screenSize.height * ratio
            }
        }
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
}
