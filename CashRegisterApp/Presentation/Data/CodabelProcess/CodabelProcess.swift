//
//  CodabelProcess.swift
//  CashRegisterApp
//
//  Created by Nahid Habibov on 15.04.26.
//

import Foundation

final class CodabelProcess {
    
    func encode(model: Encodable?) -> Data? {
        guard let encodeModel = model else { return nil}
        do {
            let data = try JSONEncoder().encode(encodeModel)
            return data
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func decode<T: Decodable>(data: Data, completion: @escaping(Result<T, Error>) -> Void) {
        do {
            let decode = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decode))
        } catch {
            completion(.failure(error))
        }
    }
}
