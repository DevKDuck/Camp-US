//
//  FeedDataManager.swift
//  Campstagram
//
//  Created by duck on 2022/09/05.
//

import Alamofire

class FeedDataManager {
    func feedDataMangager(_ parameters: FeedAPIInput, _ viewController: HomeViewController){
        AF.request("https://api.thecatapi.com/v1/images/search", method: .get, parameters: parameters).validate().responseDecodable(of: [FeedModel].self) { response in
            switch response.result{
            case .success(let result):
                viewController.successAPI(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
//HTTP 통신을 하는 객체 생성
//사용라이브러리 Alamofire
//request를 통해서 결과 값을 받아옴
//response를 받게 되면 클로져를 통해 데이터를 받아 분기문 처리

