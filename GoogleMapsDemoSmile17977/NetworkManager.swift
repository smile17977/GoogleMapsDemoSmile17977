//
//  NetworkManager.swift
//  GoogleMapsDemoSmile17977
//
//  Created by Kir Pir on 20.10.2020.
//

import Foundation

protocol NetworkManagerDelegate: class {
    func updateInterface<T>(_: NetworkManager, with data: T)
}

class NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
    func fetchUsersData() {
        guard let url = URL(string: Requests.usersUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                guard let data = data else { return }
                if let users = self.parseJSON(withData: data) {
                    self.delegate?.updateInterface(self, with: users)
                }
            }
        }.resume()
    }
    
    private func parseJSON(withData data: Data) -> [User]? {
        let decoder = JSONDecoder()
        do {
            let usersData = try decoder.decode([User].self, from: data)
            return usersData
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
