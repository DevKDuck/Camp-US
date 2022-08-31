//
//  ProfileCollectionViewCell.swift
//  Campstagram
//
//  Created by duck on 2022/08/31.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addProfileImageView: UIImageView!
    static let identifier = "ProfileCollectionViewCell" //collectionView가 생성할 cell임을 알려주자
    override func awakeFromNib() {
        super.awakeFromNib()
        setAttribute()
        // Initialization code
    }

    private func setAttribute() {
        profileImageView.cornerRadius = 88 / 2
        addProfileImageView.cornerRadius = 24 / 2 
        
    }
}
