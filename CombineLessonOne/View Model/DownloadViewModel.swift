//
//  DownloadViewModel.swift
//  CombineLessonOne
//
//  Created by David Malicke on 6/11/23.
//

import Foundation
import Observation
import Combine
import SwiftUI


// Eventkit Manager Observable Class
@Observable class DownloadViewModel {
    public var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
        //            .replaceError(with: [])
        //            .sink(receiveValue: { [weak self] (returnedPosts) in
        //                self?.posts = returnedPosts
        //            })
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print("error: \(error)")
                    // Handle error here
                    
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
        
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

@Observable class SubscriberViewModel {
    
    public var count: Int = 0
    public var textIsValid: Bool = false
    public var showButton: Bool = false
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupTimer()
    }
    
    func setupTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                // guard unwraps optional self.counter (and other values) so that
                // self?.count += 1 can be self.count += 1
                guard let self = self else { return }
                self.count += 1
                
//                if count >= 10 {
//                    for item in cancellables {
//                        item.cancel()
//                    }
//                }
            }.store(in: &cancellables)
    }
}
