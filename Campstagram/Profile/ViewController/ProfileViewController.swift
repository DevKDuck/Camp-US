//
//  ProfileViewController.swift
//  Campstagram
//
//  Created by duck on 2022/08/31.
//

import UIKit

class ProfileViewController: UIViewController {
    //MARK - Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var userFeedData: UserFeedModel?
    
    //MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupData()
    }
    
    //MARK - Actions
    
    //MARK - Helpers
    
    private func setupCollectionView(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        profileCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        //cell 등록하기
        profileCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
    }
    
    private func setupData() {
//        UserFeedDataManager().getUserFeed(self)
    }
    
}

//MARK - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }//섹션의 갯수
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return 1
        default:
            return 24
        }
        return 1
    }//Cell의 갯수
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        
        switch section{
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell else { fatalError("셀 타입 캐스팅 실패..")}
            return cell

        default:
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell else { fatalError("셀 타입 캐스팅 실패..")}
            
            let itemIndex = indexPath.item
//            self.userFeedData[itemIndex]
//            cell.setupData(imageURLStr: <#T##String?#>)
        return cell
        }//cell 생성
    }
    
    
}
extension ProfileViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.section
        switch section{
        case 0:
            return CGSize(width: collectionView.frame.width, height: 159)
        default:
            let side = CGFloat((collectionView.frame.width / 3) - (4 / 3))
            return CGSize(width: side, height: side)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section{
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }//아이템 사이 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section{
        case 0:
            return CGFloat(0)
        default:
            return CGFloat(1)
        }
    }//line 사이 간격
}

extension ProfileViewController {
    func successFeedAPI(_ result: UserFeedModel){
//        GetUserPosts
//        self.userFeedData = result
    }
}
