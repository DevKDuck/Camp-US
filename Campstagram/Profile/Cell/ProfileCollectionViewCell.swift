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
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addFriendsButton: UIButton!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var postingCountLabel: UILabel!
    static let identifier = "ProfileCollectionViewCell" //collectionView가 생성할 cell임을 알려주자
    override func awakeFromNib() {
        super.awakeFromNib()
        setAttribute()
        // Initialization code
    }

    private func setAttribute() {
        profileImageView.cornerRadius = 88 / 2
        addProfileImageView.cornerRadius = 24 / 2
        editButton.layer.cornerRadius = 5
        editButton.layer.borderColor = UIColor.lightGray.cgColor
        editButton.layer.borderWidth = 1
        
//        addFriendsButton.layer.cornerRadius = 3
//        addFriendsButton.layer.borderColor = UIColor.lightGray.cgColor
//        addFriendsButton.layer.borderWidth = 1
        
        [postingCountLabel, followerCountLabel, followingCountLabel]
            .forEach{ $0.text = "\(Int.random(in: 0...10))"}
    }
}
