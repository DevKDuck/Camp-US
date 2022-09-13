//
//  ReelsViewController.swift
//  Campstagram
//
//  Created by duck on 2022/09/08.
//

import UIKit

class ReelsViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var nowPage = 0
    
    private let videoURLStrArr = ["dummyVideo","dummyVideo2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

        // Do any additional setup after loading the view.
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = .fast //스크롤 빠르게
    
        collectionView.register(ReelsCollectionCell.self, forCellWithReuseIdentifier: ReelsCollectionCell.identifier)

        startLoop()
    }
    
    private func startLoop(){
        let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true){ _ in
            self.moveNextPage()
        }
    }
    private func moveNextPage() {
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        nowPage += 1
        if (nowPage >= itemCount){
            //마지막페이지
            nowPage = 0
        }//0번쨰 섹션 갯수 확인
        
        
        collectionView.scrollToItem(at: IndexPath(item: nowPage, section: 0), at: .centeredVertically, animated: true)
    } //collectionView가 2초마다 하나씩 내려가거나 마지막페이지가 되면 첫번째 페이지로 이동

}


extension ReelsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReelsCollectionCell.identifier, for: indexPath) as? ReelsCollectionCell else { return UICollectionViewCell()}
        cell.setupURL(videoURLStrArr.randomElement()!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ReelsCollectionCell{
            cell.videoView?.cleanup()
        }//셀이 보여주는것이 끝났을때 cleanup메소드 호출
        //queuePlayer를 멈추고, 그에대한 아이템을 제거하고 객체를 제거하여 메모리 관리
    }
    
    
}

extension ReelsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    
    
}
