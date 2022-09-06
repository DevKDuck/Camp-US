//
//  UserFeedDataManager.swift
//  Campstagram
//
//  Created by duck on 2022/09/06.
//

import Alamofire

//class UserFeedDataManager {
//    func getUserFeed(_ parameters: FeedAPIInput, _ viewController: ProfileViewController){
//        AF.request("https://api.thecatapi.com/v1/images/search", method: .get, parameters: parameters).validate().responseDecodable(of: [FeedModel].self) { response in
//            switch response.result{
//            case .success(let result):
//                viewController.sucessAPI(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//
//        }
//    }
//}
