//
//  APIManager.swift
//  Rides
//
//  Created by Vish on 2023-01-19.
//

import Foundation


enum APIError: Error{
    
    case invalidData
    case invalidResponse
    case failedToDecode
}

final class APIManager {
    
    static let shared = APIManager()
    func getVehicleModel(size: Int, completion: @escaping (Result<[Vehicle], Error>) -> (Void)){
        guard let url = URL(string: "\(Constants.baseURL)?size=\(size)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else{
                completion(.failure(APIError.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(APIError.invalidResponse))
                return
            }
    
            do{
                let result  = try JSONDecoder().decode([Vehicle].self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(APIError.failedToDecode))
            }
        }
        task.resume()
    }
}
