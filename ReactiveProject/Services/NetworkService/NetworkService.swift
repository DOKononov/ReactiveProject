//
//  NetworkService.swift
//  ReactiveProject
//
//  Created by Dmitry Kononov on 4.12.24.
//

import Foundation
import DIYReactive

final class NetworkService {
    
    private let host: String = "https://catfact.ninja"
    
    func getRandomFact() -> RxPublisher<String> {
        
        return RxResultPublisher<String>.create { resultClosure in
                    guard
                        let url = URL(string: host + "/fact")
                    else { return }
            
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
            
                    URLSession.shared.dataTask(
                        with: request
                    ) { data, response, error in
                        if let data {
                            do {
                                let model = try JSONDecoder()
                                    .decode(CatFactModel.self, from: data)
                                resultClosure(.success(model.fact))
                            } catch {
                                resultClosure(.failure(error))
                            }
                        } else if let error {
                            resultClosure(.failure(error))
                        }
                    }.resume()
        }
    }
}
