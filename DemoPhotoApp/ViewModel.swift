//
//  ViewModel.swift
//  DemoPhotoApp
//
//  Created by Rahul Sharma on 15/04/24.
//

import Foundation


class ViewModel{
    
    
    let apiClient: APIClient
    var photos = [Photo]()
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getPhots(page: Int, compilationHandler: @escaping (Bool,APIError?) -> (Void) ){
        
        let params = ["client_id":"VhuA_HYOTCH0Qef3hEPpu8KKmDf5Rdu_660YIq_pU4o","page":"\(page)"]
        apiClient.get(endpoint: APIEndPoint.photos, parameters: params) { [weak self ] result in
            
            switch result {
            case .success(let data):
                print("Before decoding")
                do {
                    
                    let decoder = JSONDecoder()
                    let photos = try decoder.decode([Photo].self, from: data)
                    
                    
                    self?.photos += photos
                    
                    print("Decoding successful")
                    print(self?.photos)
                   
                    compilationHandler(true,nil)
                } catch {
                    compilationHandler(false,.customAlert)
                    print("Error decoding JSON: \(error)")
                }
                print("After decoding")
                
            case .failure(let error):
                compilationHandler(false,error)
                print(error)
            }
        }
    }
    
    
    
}
