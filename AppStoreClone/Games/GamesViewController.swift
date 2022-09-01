//
//  GamesViewController.swift
//  AppStoreClone
//
//  Created by 1 on 2022/08/29.
//

import UIKit
import Kingfisher

class GamesViewController: UIViewController {
    @IBOutlet weak var collerctionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, FeaturedCollectionViewCellModel>? //이애가 엄청난 친구다  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = UICollectionViewDiffableDataSource<Int, FeaturedCollectionViewCellModel>(collectionView: collerctionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath)
            (cell as? FeaturedCollectionViewCell)?.setModel(itemIdentifier)
            return cell
        })
        
        collerctionView.collectionViewLayout = createFeaturedListLayout()
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, FeaturedCollectionViewCellModel>()
        snapShot.appendSections([0])
        snapShot.appendItems([FeaturedCollectionViewCellModel(featureReason: "사전예약", title: "원신2", subTitle: "원신을 뛰어넘는", mainImageUrl: "https://picsum.photos/300", appIconImageUrl: "", appName: "원신2", appType: "RPG", downloadStatus: .get, hasInAppPurchase: true),
                              FeaturedCollectionViewCellModel(featureReason: "사전예약", title: "드래곤볼2", subTitle: "드래곤볼을 뛰어넘는", mainImageUrl: "https://picsum.photos/301", appIconImageUrl: "", appName: "드래곤보2", appType: "RPG", downloadStatus: .get, hasInAppPurchase: true),
                              FeaturedCollectionViewCellModel(featureReason: "출시 진행중", title: "포켓몬고2", subTitle: "포켓몬을 뛰어넘는", mainImageUrl: "https://picsum.photos/302", appIconImageUrl: "", appName: "포켓몬고2", appType: "RPG", downloadStatus: .get, hasInAppPurchase: true),
                              FeaturedCollectionViewCellModel(featureReason: "출시 진행중", title: "던파2", subTitle: "던전을 뛰어넘는", mainImageUrl: "https://picsum.photos/303", appIconImageUrl: "", appName: "던앤파이터2", appType: "RPG", downloadStatus: .get, hasInAppPurchase: true),
                             FeaturedCollectionViewCellModel(featureReason: "사전예약", title: "스폰지밥2", subTitle: "드래곤볼을 뛰어넘는", mainImageUrl: "https://picsum.photos/304", appIconImageUrl: "", appName: "스폰지밥2", appType: "RPG", downloadStatus: .get, hasInAppPurchase: true)],
                              toSection: 0)
        dataSource?.apply(snapShot, animatingDifferences: true)
    }
    func createFeaturedListLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(collerctionView.frame.width - 60), heightDimension: .absolute(330))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging //셀 가로로 바꾸기
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 15) // 사진 양옆에 자리를 만든다
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension GamesViewController: UICollectionViewDelegate {
    
}
