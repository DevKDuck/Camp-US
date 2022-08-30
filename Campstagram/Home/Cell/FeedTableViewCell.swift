//
//  FeedTableViewCell.swift
//  Campstagram
//
//  Created by duck on 2022/08/30.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewUserProfile: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var imageViewFeed: UIImageView!
    @IBOutlet weak var buttonIsHeart: UIButton!
    @IBOutlet weak var buttonIsBookMark: UIButton!
    @IBOutlet weak var labelFeed: UILabel!
    @IBOutlet weak var labelHowManyLike: UILabel!
    @IBOutlet weak var imageViewMyProfile: UIImageView!
    
    
    @IBAction func actionIsHeart(_ sender: Any) {
        if buttonIsHeart.isSelected == true {
            buttonIsHeart.isSelected = false
        }else{
            buttonIsHeart.isSelected = true
        }
    }
    
    @IBAction func actionBookMark(_ sender: Any) {
        if buttonIsBookMark.isSelected == true{
            buttonIsBookMark.isSelected = false
        }else{
            buttonIsBookMark.isSelected = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageViewUserProfile.layer.cornerRadius = 12.5
        imageViewUserProfile.clipsToBounds = true
        imageViewMyProfile.layer.cornerRadius = 12.5
        imageViewMyProfile.clipsToBounds = true
        
        
        //labelFeed의 글자꼴을 각각 설정하고 싶을때
        let fontSize = UIFont.boldSystemFont(ofSize: 9)
        let attributedStr = NSMutableAttributedString(string: labelFeed.text ?? "")
        attributedStr.addAttribute(.font, value: fontSize, range:NSRange.init(location: 0, length: 3))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
