//
//  ApiManger.swift
//  MEdiaFinder 2
//
//  Created by nassermac on 6/4/23.
//  Copyright © 2023 Nasser Co. All rights reserved.
//

import UIKit
import Alamofire


class ApiManger {
   
    private static let sharedInstance = ApiManger()
    
    class func shared()->ApiManger{
        return ApiManger.sharedInstance
    }
    
    func getdata(mypara:[String:String],completion: @escaping(_ error: Error?, _ empArray: [Artist]?)-> Void){
        Alamofire.request(URLs.search, method: HTTPMethod.get, parameters: mypara, encoding: URLEncoding.default, headers: nil).response { (response) in
        
//            guard let error = response.error else {return}
//            print("API request error: \(error.localizedDescription)")
//            completion(error, nil)
            
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("I Can Not Found a Data ")
                return}
            do{
                let decoder = JSONDecoder()
                let artistdecoder = try decoder.decode(searchResponse.self, from: data)
                let employeeArr = artistdecoder.results
                completion(nil, employeeArr)
            } catch let error{
                print("Error decoding response data: \(error.localizedDescription)")
                completion(error, nil)
            }
        }
    }

    
    
    
    func getFilterData(mypara:[String:String],completion: @escaping(_ error: Error?, _ empArray: [Artist]?)-> Void){
        Alamofire.request(URLs.search, method: HTTPMethod.get, parameters: mypara, encoding: URLEncoding.default, headers: nil).response { (response) in
            guard response.error == nil else {
                print(response.error!)
                completion(response.error, nil)
                return
            }
            
            guard let data = response.data else {
                print("I Can Not Found a Data ")
                return}
            do{
                let decoder = JSONDecoder()
                let artistdecoder = try decoder.decode(searchResponse.self, from: data)
                let employeeArr = artistdecoder.results
                completion(nil, employeeArr)
            } catch let error{
                print("Error decoding response data: \(error.localizedDescription)")
                completion(error, nil)
            }
        }
    }

    
    
  
}
