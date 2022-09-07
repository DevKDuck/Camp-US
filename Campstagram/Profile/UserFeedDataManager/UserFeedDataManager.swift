//
//  UserFeedDataManager.swift
//  Campstagram
//
//  Created by duck on 2022/09/06.
//

import Alamofire

class UserFeedDataManager {
    func getUserFeed(_ viewController: ProfileViewController,_ userID: Int = 2){
        AF.request("https://edu-api-ios-test.softsquared.com/users/\(userID)", method: .get, parameters: nil).validate().responseDecodable(of: UserFeedModel.self) { response in
            switch response.result{
            case .success(let result):
                print("DEBUG: ", result)
                viewController.successFeedAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }//데이터 통신을 하고 나서 그 결과값을 받아온 다음 viewController에 전달하려고 파라미터로 받음

    func deleteuserFeed(_ viewController: ProfileViewController,_ postIdx: Int){
        AF.request("https://edu-api-ios-test.softsquared.com/posts/\(postIdx)/status", method: .patch, parameters: nil).validate().responseDecodable(of: DeleteuserFeed.self) { response in
            switch response.result{
            case .success(let result):
                viewController.successDeletePostAPI(result.isSuccess ?? false)
                
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }//데이터 통신을 하고 나서 그 결과값을 받아온 다음 viewController에 전달하려고 파라미터로 받음

    
    
    
}

