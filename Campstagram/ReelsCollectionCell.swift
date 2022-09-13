//
//  ReelsCollectionCell.swift
//  Campstagram
//
//  Created by duck on 2022/09/13.
//

import UIKit
import SnapKit
import AVKit


class ReelsCollectionCell: UICollectionViewCell{
    static let identifier = "ReelsCollectionCell"
    
    
    var videoView: VideoPlayerView?
    
    //추후에 버튼으로 수정
    
    //릴스
    let cellTitleLabel = UILabel()
    
    // 카메라
    let cameraIamgeView = UIImageView()
    
    //댓글
    let commentImageView = UIImageView()
    
    //좋아요
    let likeImageView = UIImageView()
    
    //공유
    let shareImageView = UIImageView()
    
    //초기화 생성
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)has not been implemented")
    }
    
    public func setupURL(_ urlStr: String){
        self.videoView = VideoPlayerView(frame: .zero, urlStr: urlStr)
        setupAttribute()
        setupLayout()
    }
    
    private func setupAttribute() {
        cellTitleLabel.text = "릴스"
        cellTitleLabel.font = .boldSystemFont(ofSize: 25)
        cellTitleLabel.textAlignment = .left
        
        
        [cameraIamgeView, shareImageView, commentImageView, likeImageView]
            .forEach {
                $0.contentMode = .scaleAspectFit
                $0.tintColor = .white
            }
        cameraIamgeView.image = UIImage(systemName: "camera")
        shareImageView.image = UIImage(systemName: "paperplane")
        commentImageView.image = UIImage(systemName: "message")
        likeImageView.image = UIImage(systemName: "suit.heart")
     
        
        
    }
    
    private func setupLayout(){
        guard let videoView = videoView else {
            return
        }
        contentView.addSubview(videoView)
        
        videoView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        } //viewoView에 모든 값에대해서 contentView에 맞춤
        
        [cellTitleLabel, cameraIamgeView,
         likeImageView,
         commentImageView,
         shareImageView]
            .forEach { contentView.addSubview($0)}
        cellTitleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        cameraIamgeView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)
        }
        
        shareImageView.snp.makeConstraints{ make in
            make.bottom.equalToSuperview().offset(-50)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(35)

        }
        
        let space = CGFloat(-20)
        commentImageView.snp.makeConstraints{ make in
            make.bottom.equalTo(shareImageView.snp.top).offset(space)
            make.centerX.equalTo(shareImageView)
            make.width.height.equalTo(35)
        }
        likeImageView.snp.makeConstraints{ make in
            make.bottom.equalTo(commentImageView.snp.top).offset(space)
            make.centerX.equalTo(commentImageView)
            make.width.height.equalTo(35)
        }
        
    }
}
