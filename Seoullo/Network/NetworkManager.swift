//
//  NetworkManager.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import Foundation
import Alamofire


class NetworkManager {
    static var Headers : HTTPHeaders = ["Content-Type" : "application/json"]
    
//    static func posts(_ parameter: KakaoInput,_ completion: @escaping (String) -> Void){
//        AF.request(Secret.loginURL, method: .post, parameters: parameter, encoder: JSONParameterEncoder.default, headers: Headers)
//            .validate(statusCode: 200..<500)
//            .responseDecodable(of: KakaoModel.self) { response in
//            switch response.result {
//            case .success(let result):
//                print("카카오 데이터 전송 성공")
//                print(result)
//                switch(result.code){
//                case "A000":
//                    completion
//                    return
//                case "A001":
//                    completion
//                    return
//                default:
//                    print("데이터베이스 오류")
//                    return
//                }
//            case .failure(let error):
//                print("카카오 데이터 전송 실패")
//                print(error.localizedDescription)
//                print(response.error ?? "")
//            }
//        }
//    }
}
