//
//  NetworkManager.swift
//  IzibookTestProject
//
//  Created by Eugene Kireichev on 11/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import Foundation

typealias ImageData = Data
typealias DownloadedData = (CatalogData, [ImageData])

class NetworkManager: NSObject {
    
    private let authURLString = "https://authan-test.izibook.ru:13302/api/anonymous"
    private let catalogURLString = "https://rest-test.izibook.ru:10001/api/globcat/list"
    private let imageURLString = "https://mi-test.izibook.ru/imagemanager/manager/singleget?"
    
    private var pkcs12String = ""

    func downloadCatalogData(completion: @escaping (Result<DownloadedData, Error>) -> Void) {
        authPostRequest { authResult in
            switch authResult {
            case .failure(let networkError): DispatchQueue.main.async { completion(.failure(networkError)) }
            case .success:
                self.catalogPostRequest { catalogResult in
                    switch catalogResult {
                    case .failure(let networkError): DispatchQueue.main.async { completion(.failure(networkError)) }
                    case .success(let catalogData):
                        var counter = 0
                        var fetchedImageDataset = [ImageData](repeating: ImageData(), count: catalogData.data.count)
                        for index in 0..<catalogData.data.count {
                            self.imageDataGetRequest(iconID: catalogData.data[index].icon, imageWidth: 100, imageHeight: 100) { imageResult in
                                counter += 1
                                switch imageResult {
                                case .failure(_): return
                                case .success(let imageData): fetchedImageDataset[index] = imageData
                                }
                                guard counter == catalogData.data.count else { return }
                                DispatchQueue.main.async { completion(.success((catalogData, fetchedImageDataset))) }
                            }
                        }
                    }
                }
            }
        }
    }

    private func authPostRequest(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: authURLString) else { fatalError("Invalid URL String") }
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data else { completion(.failure(DefaultNetworkError())); return }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let rawModel = try? decoder.decode(AuthResponse.self, from: data) else {
                if let rawError = try? decoder.decode(AuthError.self, from: data) {
                    completion(.failure(rawError))
                } else {
                    completion(.failure(DefaultNetworkError()))
                }
                return
            }
            self?.pkcs12String = rawModel.data.pkcs12
            completion(.success(()))
        }
        task.resume()
    }

    private func catalogPostRequest(completion: @escaping (Result<CatalogData, Error>) -> Void) {
        guard let url = URL(string: catalogURLString) else { fatalError("Invalid URL String") }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("ru-RU", forHTTPHeaderField: "x-lang")
        
        let encoder = JSONEncoder()
        let body = CatalogRequestBody(
            filter: Filter(parent: 1),
            view: [
                Item(code: "icon"),
                Item(code: "id"),
                Item(code: "title"),
                Item(code: "popularity"),
                Item(code: "items", view: [
                    Item(code: "id"),
                    Item(code: "title"),
                    Item(code: "items", view: [
                        Item(code: "id"),
                        Item(code: "title")
                    ])
                ])
            ]
        )
        guard let jsonData = try? encoder.encode(body) else { fatalError("Invalid Request Body Struct") }
        request.httpBody = jsonData
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(.failure(DefaultNetworkError()))
                session.finishTasksAndInvalidate()
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let rawModel = try? decoder.decode(CatalogData.self, from: data) else {
                completion(.failure(DefaultNetworkError()))
                session.finishTasksAndInvalidate()
                return
            }
            completion(.success(rawModel))
            session.finishTasksAndInvalidate()
        }
        task.resume()
    }
    
    private func imageDataGetRequest(iconID: String, imageWidth: Int, imageHeight: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        let modifiedImageURLString = imageURLString + "&image=\(iconID)&h=\(imageHeight)&w=\(imageWidth)"
        guard let url = URL(string: modifiedImageURLString) else { fatalError() }
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(DefaultNetworkError()))
            }
            session.finishTasksAndInvalidate()
        }
        task.resume()
    }

}

extension NetworkManager: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        guard let p12Data = Data(base64Encoded: pkcs12String) else { fatalError("Invalid PCKS12 String") }

        let sertData = PKCS12(PKCS12Data: p12Data as NSData)
        let credential = URLCredential(PKCS12: sertData)
        
        completionHandler(.useCredential, credential)
    }
    
}
