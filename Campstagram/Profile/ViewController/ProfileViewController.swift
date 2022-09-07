//
//  ProfileViewController.swift
//  Campstagram
//
//  Created by duck on 2022/08/31.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate{
    //MARK - Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var userPosts: [GetUserPosts]? {
        didSet {self.profileCollectionView.reloadData()}
    }//UI를 만들고 네트워크 통신이 성공하여 reloadData를 해줘 데이터의 값이 변경되었을때 UI를 다시그리게함
    
    
    var deletedIndex: Int? //삭제된 인덱스
    
    //MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupData()
        
    }
    
    //MARK - Actions
    @objc
    func didLongPressCell(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state != .began {return}
        
        let position = gestureRecognizer.location(in: profileCollectionView)
        
        if let indexPath = profileCollectionView?.indexPathForItem(at: position){
            print("DEBUG: ", indexPath.item)
            
            guard let userPosts = userPosts else {return}

            let cellData = userPosts[indexPath.item]
            self.deletedIndex = indexPath.item
            if let postIdx = cellData.postIdx{
                //삭제 API호출
                UserFeedDataManager().deleteuserFeed(self, postIdx)
            }

        }
    }//오래 눌렀을때 인지하는 객체
    
    
    //MARK - Helpers
    
    private func setupCollectionView(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        profileCollectionView.register(UINib(nibName: "ProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        //cell 등록하기
        profileCollectionView.register(UINib(nibName: "PostCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressCell(gestureRecognizer:)))
        gesture.minimumPressDuration = 0.66
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        profileCollectionView.addGestureRecognizer(gesture)
    } //didselect 메소드를 이용해도 되지만 범용성을 위해 오래 눌렀을 경우에 UILongPressGestureRecognizer 사용
    
    
    private func setupData() {
        UserFeedDataManager().getUserFeed(self)
    } //데이터 가져오는 부분
    
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
            return userPosts?.count ?? 0
        }
    }//Cell의 갯수
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        
        switch section{
        case 0: //Profile
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as? ProfileCollectionViewCell else { fatalError("셀 타입 캐스팅 실패..")}
            return cell

        default: //Post
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as? PostCollectionViewCell else { fatalError("셀 타입 캐스팅 실패..")}
            
            let itemIndex = indexPath.item
            if let cellData = self.userPosts{
                //데이터가 있는 경우 셀에 데이터 전달
                cell.setupData(cellData[itemIndex].postImgUrl)
            }
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


//MARK: - API 통신 메소드
extension ProfileViewController {
    func successFeedAPI(_ result: UserFeedModel){
        self.userPosts  = result.result?.getUserPosts
    }
    func successDeletePostAPI(_ isSuccess: Bool){
        guard isSuccess else {return}
        if let deletedIndex = self.deletedIndex{
            self.userPosts?.remove(at: deletedIndex)
        }
    }//삭제에 성공하게 되면 로컬에서 직접 삭제하도록
}
