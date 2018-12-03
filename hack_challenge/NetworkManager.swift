//
//  NetworkManager.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/29/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private static let url = "http://35.243.161.172/api/times/"
    
    static func getLibraries(completion: @escaping ([Library]) -> Void) {
        Alamofire.request(url, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
            let jsonDecoder = JSONDecoder()
            
            if let libraryResponse = try? jsonDecoder.decode(finalLibraryResponse.self, from: data) {
                // Call the function we passed in to do whatever we want
                // to the classes array (eg. show it on screen)
                libraryResponse.data.libraries.forEach({ (library) in
                    library.calculateStatus()
                })
                completion(libraryResponse.data.libraries)
            } else {
                print("Invalid Response Data")
            }
            case .failure(let error):
            print(error.localizedDescription)
        }
    }
    }
    
   static func getImageFromURLString(urlString: String) -> UIImage? {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    
    

    
}
