//
//  MLRequestService.swift
//  MealBuilder
//
//  Created by Ryan Nguyen on 7/25/24.
//

import Foundation

class MLRequestService: ObservableObject {
    @Published var responseData: Recipe?
    @Published var errorMessage: String?
    @Published var history: [Recipe] = []
    
    private let maxRetryCount = 3
    
    func postRequest(urlString: String, parameters: [String: Any], completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            self.errorMessage = "Failed to serialize JSON: \(error.localizedDescription)"
        }
        
        executeRequest(request: request, retryCount: 0, completion: completion)
    }
    
    private func executeRequest(request: URLRequest, retryCount: Int, completion: @escaping (Bool) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    if retryCount < self.maxRetryCount - 1 {
                        print("Error: \(error.localizedDescription). Retrying... \(retryCount + 1)/\(self.maxRetryCount)")
                        self.executeRequest(request: request, retryCount: retryCount + 1, completion: completion)
                    } else {
                        self.errorMessage = "Error: \(error.localizedDescription)"
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    if response.statusCode != 200 {
                        if retryCount < self.maxRetryCount - 1 {
                            print("Response HTTP Status code: \(response.statusCode). Retrying... \(retryCount + 1)/\(self.maxRetryCount)")
                            self.executeRequest(request: request, retryCount: retryCount + 1, completion: completion)
                        } else {
                            self.errorMessage = "Response HTTP Status code: \(response.statusCode)"
                        }
                        return
                    }
                }
                
                if let data = data {
                    do {
                        print("Starting decode attempt \(retryCount + 1)...")
                        let decoder = JSONDecoder()
                        let _response = try decoder.decode(MLResponse.self, from: data)
                        var recipe = _response.body
                        recipe.id = .init()
                        print("Decoding successful")
                        print("\n\n\nRECIPE: \(recipe)")
                        
                        // Handle the decoded recipe, e.g., assign it to a published property
                        self.responseData = recipe
                        self.history.append(recipe)
                        print("done. quitting...")
//                        print("\n\nhistory:\(self.history)")
                        completion(true)
                    } catch {
                        if retryCount < self.maxRetryCount - 1 {
                            print("Decoding failed: \(error.localizedDescription). Retrying... \(retryCount + 1)/\(self.maxRetryCount)")
                            self.executeRequest(request: request, retryCount: retryCount + 1, completion: completion)
                        } else {
                            self.errorMessage = "Failed to decode data after \(self.maxRetryCount) attempts: \(error.localizedDescription). Try again."
                            completion(false)
                        }
                    }
                }
            }
        }
        
        task.resume()
    }
}
