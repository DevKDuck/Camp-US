//
//  HomeViewController.swift
//  Campstagram
//
//  Created by duck on 2022/08/30.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var arrayCat : [FeedModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.separatorStyle = .none //cell 구분하는스타일을 없앰
        
        //tableView에 등록해 야함 nib을 사용함
        let feedNib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedNib, forCellReuseIdentifier: "FeedTableViewCell")
        
        
        let storyNib = UINib(nibName: "StoryTableViewCell", bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: "StoryTableViewCell")
        let input = FeedAPIInput(limit: 20, Page: 10)
        FeedDataManager().feedDataMangager(input, self)
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCat.count + 1
    } //한 섹션에 몇개의 셀을 넣을 것인지?
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryTableViewCell", for: indexPath) as? StoryTableViewCell else{
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell else {
                return UITableViewCell()
                
            }
            if let urlString = arrayCat[indexPath.row - 1].url{
                let url = URL(string: urlString)
                cell.imageViewFeed.kf.setImage(with: url)
            }
            cell.selectionStyle = .none //cell이 선택되었을때 고유한 스타일을 없앰
            return cell
        }//어떤 셀을 보여줄 것인지
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else{
            return 600
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? StoryTableViewCell else{
            return
        }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegtate: self, forRow: indexPath.row)
    }//cell이 보여질때 collectionview를 보여주도록 할것임
    
}

extension HomeViewController : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }//한 섹션에 몇개의 셀을 넣을 것인지?
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionViewCell", for: indexPath) as? StoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }//어떤 셀을 보여줄 것인지
    
    //콜렉션뷰는 반드시 높이와 넓이를 설정해주어야함
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 60)
    }
    
}

extension HomeViewController{
    func sucessAPI(_ result: [FeedModel]) {
        arrayCat = result
        tableView.reloadData()
        
    }
}
