//
//  APIManager.swift
//  WeatherMapData
//
//  Created by Ravi Sendhav on 26/03/19.
//  Copyright © 2019 Ravi Sendhav. All rights reserved.
//

import Foundation

typealias ServiceResponse = (Dictionary<String, AnyObject>) -> Void

struct APIManager {
    
    static let sharedInstance = APIManager()
    
    func makeHTTPGetRequest(_ path: String, onCompletion: @escaping ServiceResponse) {
        
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
                
                if error == nil {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    
                    onCompletion(json)
                }
                else {
                    // TODO: Handle API error according to requirment
                }
                
                // If we get server response in array form we can use |Model| with |Codable| protocol to parse and configure response data with Model like i have managed below commented code
                
                //                guard let dataMap = try? JSONSerialization.data(withJSONObject: arrTemp!, options: []) else {
                //                    return
                //                }
                //
                //                //created the json decoder
                //                let decoder = JSONDecoder()
                //
                //                //using the array to put values
                //                self?.arrWeatherMapData = try decoder.decode([WeatherMapData].self, from: dataMap)
                
            }
            catch {
                print("error")
            }
        })
        task.resume()
    }
    
}
