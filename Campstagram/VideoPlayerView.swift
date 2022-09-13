//
//  VideoPlayerView.swift
//  Campstagram
//
//  Created by duck on 2022/09/13.
//

import UIKit
import AVKit

class VideoPlayerView: UIView {
    
    var playerLayer: AVPlayerLayer?  //재생될때 레이어크기 담당
    var playerLooper: AVPlayerLooper? // 반복재생 담당
    var queuePlayer: AVQueuePlayer? //선입선출 재생 담당
    var urlStr: String
    
    init(frame: CGRect, urlStr: String){
        self.urlStr = urlStr
        super.init(frame: frame)
    
        let videoFileURL = Bundle.main.url(forResource: urlStr, withExtension: "mp4")!
        let playItem = AVPlayerItem(url: videoFileURL)
        
        self.queuePlayer = AVQueuePlayer(playerItem: playItem)
        playerLayer = AVPlayerLayer()
        
        playerLayer!.player = queuePlayer
        playerLayer!.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(playerLayer!)
        
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playItem)
        queuePlayer!.play()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func cleanup(){
        queuePlayer?.pause()
        queuePlayer?.removeAllItems()
        queuePlayer = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer!.frame = bounds
    }
}
