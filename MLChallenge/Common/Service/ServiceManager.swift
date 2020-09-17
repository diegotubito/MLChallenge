//
//  ServiceManager.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import UIKit

enum ServiceError : String , Error {
    case wrongURL = "The url sent is not correct"
    case nilData = "Empty"
    case decode = "Could not decode data"
    case unknown = "Unknown error, please try again later"
    case noImage = "The image could not be founded"
}

protocol ServiceManagerProtocol {
    func retrieveData(stringURL: String, completion: @escaping(Data?, ServiceError?) -> Void)
}

class ServiceManager: ServiceManagerProtocol {
    
    func retrieveData(stringURL: String, completion: @escaping(Data?, ServiceError?) -> Void){
        
        let encode = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let adaptedUrl = encode,
            let url = NSURL(string: adaptedUrl) as URL?
            else {
            completion(nil, ServiceError.wrongURL)
            return
        }
        
        let request: NSMutableURLRequest = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            guard error == nil else {
                completion(nil, (error as! ServiceError))
                return
            }
            
            guard let data = data else {
                completion(nil, ServiceError.nilData)
                return
            }
            
            completion(data, nil)
        })
        task.resume()
    }
    
    
    func downloadImageFromUrl(url: String, result: @escaping (Data?, String) -> Void, fail: @escaping (ServiceError?, String) -> Void) {
       
        
        guard let finalURL = URL(string: url) else {
            result(nil, url)
            return
        }
        
        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: finalURL) { (
            data, response, error) -> Void in
            guard error == nil else {
                fail(error as? ServiceError, url)

                return
            }
            DispatchQueue.main.async {
                  result(data, url)
            }
        }
        dataTask.resume()
    }
}

