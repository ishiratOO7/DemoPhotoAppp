//
//  APIClient.swift
//  DemoPhotoApp
//
//  Created by Rahul Sharma on 15/04/24.
//

import Foundation

enum APIError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case unknown
    case customAlert
}

class APIClient {
    let baseURL: URL
    private let apiLoader = APILoader.shared
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func get(endpoint: String, parameters: [String: String], completion: @escaping (Result<Data, APIError>) -> Void) {
        apiLoader.showLoader()
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: true)!
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = components.url else {
            apiLoader.hideLoader()
            completion(.failure(.unknown))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print(request, url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Hide loader regardless of result
                    
            if error != nil {
                completion(.failure(.unknown))
                self.apiLoader.hideLoader()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                
                completion(.failure(.unknown))
                self.apiLoader.hideLoader()
                return
            }
            
            self.apiLoader.hideLoader()
            switch httpResponse.statusCode {
            case 200:
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.unknown))
                }
            case 400:
                completion(.failure(.badRequest))
            case 401:
                completion(.failure(.unauthorized))
            case 403:
                completion(.failure(.forbidden))
            case 404:
                completion(.failure(.notFound))
            case 500, 503:
                completion(.failure(.serverError))
            default:
                completion(.failure(.unknown))
            }
        }
        
        task.resume()
    }

}

//// Example usage:
//let apiClient = APIClient(baseURL: URL(string: "https://api.example.com")!)
//apiClient.get(endpoint: "exampleEndpoint", parameters: ["param1": "value1"]) { result in
//    switch result {
//    case .success(let data):
//        // Handle successful response
//        print("Received data: \(data)")
//    case .failure(let error):
//        // Handle error
//        print("Error: \(error)")
//    }
//}
