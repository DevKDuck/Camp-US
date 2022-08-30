//
//  StoryTableViewCell.swift
//  Campstagram
//
//  Created by duck on 2022/08/30.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    func setCollectionViewDataSourceDelegate(dataSourceDelegtate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int){
        collectionView.delegate = dataSourceDelegtate
        collectionView.dataSource = dataSourceDelegtate
        collectionView.tag = row
        let storyNib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        collectionView.register(storyNib, forCellWithReuseIdentifier: "StoryCollectionViewCell")
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = . horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        flowLayout.minimumLineSpacing = 12
        
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.reloadData()
    }//이 함수를 HomeViewController에 가져가서 사용할 것임
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var collectionView: UICollectionView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
