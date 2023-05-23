//
//  NetworkManager.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/22.
//

import Foundation
import Alamofire
import SwiftyJSON



class NetworkManager {
    static let shared = NetworkManager()
    
//MARK: - 서울시 채용공고
    func employGet(_ completion: @escaping ([RowModel]) -> Void){
        AF.request("\(Secret.baseURL)\(Secret.employKEY)/json/GlobalJobSearch/1/5/").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let GlobalJobSearch = json["GlobalJobSearch"]
                let rows = GlobalJobSearch["row"].arrayValue
                
                do {
                    let dictionaries = rows.map { $0.dictionaryObject } // Convert each JSON object to a dictionary
                    let jsonData = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                    let rowModels = try JSONDecoder().decode([RowModel].self, from: jsonData)
                    print(rowModels)
                    completion(rowModels)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
            case .failure(let error):
                print("데이터 get 실패")
                print(error.localizedDescription)
                print(response.error ?? "")
            }
                
        }
    }
    
//MARK: - 서울시 자료실
    func infoCenterGet(_ completion: @escaping ([RowModel]) -> Void) {
        
        AF.request("\(Secret.baseURL)\(Secret.informationCenterKEY)/json/TBordCont9/1/5/").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let TBordcont9 = json["TBordCont9"]
                let rows = TBordcont9["row"].arrayValue
                
                do {
                    let dictionaries = rows.map { $0.dictionaryObject } // Convert each JSON object to a dictionary
                    let jsonData = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                    let rowModels = try JSONDecoder().decode([RowModel].self, from: jsonData)
                    completion(rowModels)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
            case .failure(let error):
                print("데이터 get 실패")
                print(error.localizedDescription)
                print(response.error ?? "")
            }
        }
    }
    
//MARK: - 서울시 정보
    func seoulInfoGet(_ completion: @escaping ([RowModel]) -> Void){
        AF.request("\(Secret.baseURL)\(Secret.seoulInfoKEY)/json/TBordCont5/1/5/").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let TBordCont5 = json["TBordCont5"]
                let rows = TBordCont5["row"].arrayValue
                
                do {
                    let dictionaries = rows.map { $0.dictionaryObject } // Convert each JSON object to a dictionary
                    let jsonData = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                    let rowModels = try JSONDecoder().decode([RowModel].self, from: jsonData)
                    print(rowModels)
                    completion(rowModels)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
            case .failure(let error):
                print("데이터 get 실패")
                print(error.localizedDescription)
                print(response.error ?? "")
            }
                
        }
    }

//MARK: - 서울시 교육 정보
    func educationGet(_ completion: @escaping ([EduModel]) -> Void){
        AF.request("\(Secret.baseURL)\(Secret.educationProgramKEY)/json/TEducProg/1/5/").responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let TEducProg = json["TEducProg"]
                let rows = TEducProg["row"].arrayValue
                
                do {
                    let dictionaries = rows.map { $0.dictionaryObject } // Convert each JSON object to a dictionary
                    let jsonData = try JSONSerialization.data(withJSONObject: dictionaries, options: [])
                    let rowModels = try JSONDecoder().decode([EduModel].self, from: jsonData)
//                    print(rowModels)
                    completion(rowModels)
                    
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
            case .failure(let error):
                print("데이터 get 실패")
                print(error.localizedDescription)
                print(response.error ?? "")
            }
                
        }
    }
    
}
