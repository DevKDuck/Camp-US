//
//  FeedUploadModel.swift
//  Campstagram
//
//  Created by duck on 2022/09/06.
//

struct FeedUploadModel: Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : FeedUploadResult?
}

struct FeedUploadResult: Decodable {
    var postIdx : Int?
}
