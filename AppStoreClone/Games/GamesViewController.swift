//
//  GamesViewController.swift
//  AppStoreClone
//
//  Created by 1 on 2022/08/29.
//

import UIKit
import Kingfisher  // 이미지 캐싱을 도와주는 라이브러리
import Alamofire  //화면이 뜰때 해야한다.   ??? 라이브러리

class GamesViewController: UIViewController {
    @IBOutlet weak var collerctionView: UICollectionView! {
        didSet {
            collerctionView.collectionViewLayout = createFeaturedListLayout()
        }
    }
    //이애가 엄청난 친구다
    lazy var dataSource: UICollectionViewDiffableDataSource<Int, FeaturedCollectionViewCellModel>? =
    UICollectionViewDiffableDataSource<Int, FeaturedCollectionViewCellModel>(collectionView: collerctionView, cellProvider: { collectionView, indexPath, itemIdentifier in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCollectionViewCell", for: indexPath)
        (cell as? FeaturedCollectionViewCell)?.setModel(itemIdentifier)
        return cell
    })
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 뷰디드로드 간소화 보기편하게 하기 위해서 펑션을 만들어서 축소한다.
        
        callAPI()
    }
    
    
    func callAPI() {
        AF.request("https://rss.applemarketingtools.com/api/v2/kr/music/most-played/10/music-videos.json").response { dataresponse in
            guard let data = dataresponse.data else { return } //data 가 옵셔널이라서 가드렛
            let musicVideoFeed = try! JSONDecoder().decode(MusicVideoFeed.self, from: data)
            let cellModel = musicVideoFeed.feed.results.map {
                FeaturedCollectionViewCellModel(featureReason: $0.releaseDate,
                                                title: $0.name,
                                                subTitle: $0.artistName,
                                                mainImageUrl: $0.artworkUrl100.replacingOccurrences(of: "/100x56mv.jpg", with: "/1000x56mv.jpg"),
                                                appIconImageUrl: $0.artworkUrl100,
                                                appName: $0.name,
                                                appType: $0.genres.first?.name.rawValue ?? "",
                                                downloadStatus: .get, hasInAppPurchase: true)
            }
            print("결과\(musicVideoFeed)")
            self.reloadData(cellModel)
        }
    }
    
    func reloadData(_ cellModel: [FeaturedCollectionViewCellModel] ) {
        var snapShot = NSDiffableDataSourceSnapshot<Int, FeaturedCollectionViewCellModel>()
        snapShot.appendSections([0])
        snapShot.appendItems(cellModel,
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
