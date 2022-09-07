//
//  UserFeedModel.swift
//  Campstagram
//
//  Created by duck on 2022/09/06.
//

import Foundation
import SwiftUI

struct UserFeedModel: Decodable {
    
    let isSuccess: Bool?
    let code: Int?
    let message: String?
    let result: UserFeedModelResult?
    
}

struct GetUserInfo: Decodable {
    
    let userIdx: Int?
    let nickName: String?
    let name: String?
    let profileImgUrl: String?
    let website: String?
    let introduction: String?
    let followerCount: Int?
    let followeeCount: Int?
    let postCount: Int?
    
}

struct GetUserPosts: Decodable {
    
    let postIdx: Int?
    let postImgUrl: String?

}


struct UserFeedModelResult: Decodable {
    
    let _isMyFeed: Bool?
    let getUserInfo: GetUserInfo?
    let getUserPosts: [GetUserPosts]?   

}























