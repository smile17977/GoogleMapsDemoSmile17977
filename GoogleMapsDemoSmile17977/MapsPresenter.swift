//
//  MapsPresenter.swift
//  GoogleMapsDemoSmile17977
//
//  Created by Kir Pir on 22.10.2020.
//

import Foundation

protocol MapsPresenterProtocol {
    init(view: MapsViewControllerProtocol)
    func getUsers()
}

class MapsPresenter: MapsPresenterProtocol {
    
    private let view: MapsViewControllerProtocol!
    private let networkManager = NetworkManager()
    private var users = [User]()
    
    required init(view: MapsViewControllerProtocol) {
        self.view = view
        self.networkManager.delegate = self
    }
    
    func getUsers() {
        networkManager.fetchUsersData()
    }
}

extension MapsPresenter: NetworkManagerDelegate {
    func updateInterface<T>(_: NetworkManager, with data: T) {
        guard let users = data as? [User] else { return }
        view.createMarkers(for: users)
    }
}
