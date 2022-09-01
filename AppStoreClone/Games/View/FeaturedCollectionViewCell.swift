//
//  FeaturedCollectionViewCell.swift
//  AppStoreClone
//
//  Created by 1 on 2022/09/01.
//

import UIKit
import Kingfisher
struct FeaturedCollectionViewCellModel: Hashable {
    enum DownloadStatus {
        case get
        case open
        case cloud
    }
    
    let featureReason: String
    let title: String
    let subTitle: String
    let mainImageUrl: String
    let appIconImageUrl: String
    let appName: String
    let appType: String
    let downloadStatus: DownloadStatus
    let hasInAppPurchase: Bool
    
}

class FeaturedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var appIconImageVIew: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var appTypeLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var hasInAppPurchaseLabel: UILabel!
    
    func setModel(_ model: FeaturedCollectionViewCellModel) {
        blueLabel.text = model.featureReason
        titleLabel.text = model.title
        subtitleLabel.text = model.subTitle
        if let url = URL(string: model.mainImageUrl) {
            mainImageView.kf.setImage(with: url)
            mainImageView.layer.cornerRadius = 10
        }
//        appIconImageVIew.image =
        appNameLabel.text = model.appName
        appTypeLabel.text = model.appType
        switch model.downloadStatus {
        case .get:
            downloadButton.setTitle("GET", for: .normal)
        case .open:
            downloadButton.setTitle("OPEN", for: .normal)
        case .cloud :
            break
        }                    //히든 안보인다?    ! 줘서 보이게한다?
        hasInAppPurchaseLabel.isEnabled = !model.hasInAppPurchase
    }
}
