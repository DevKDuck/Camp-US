//
//  PostCollectionViewCell.swift
//  Campstagram
//
//  Created by duck on 2022/09/02.
//

import UIKit
import Kingfisher

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"
    
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    public func setupData(imageURLStr: String?){
        //이미지 뷰의 이미지를 업로드함
        guard let  imageURLStr = imageURLStr else {return}
        if let url = URL(string: imageURLStr){
            postImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo"))
        
        }
    }

}
