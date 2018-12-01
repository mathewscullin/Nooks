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
    
    static func getLibraries(completion: @escaping ([Library]) -> Void) {
    }
    
    func getImageFromURLString(urlString: String) -> UIImage? {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
        }
        return nil
    }
    
    
    

    
}
