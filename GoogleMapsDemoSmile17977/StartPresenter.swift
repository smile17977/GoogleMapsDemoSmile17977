//
//  StartPresenter.swift
//  GoogleMapsDemoSmile17977
//
//  Created by Kir Pir on 22.10.2020.
//

import Foundation

protocol StartPresenterProtocol {
    init(view: StartViewControllerProtocol)
}

class StartPresenter: StartPresenterProtocol {
    
    let view: StartViewControllerProtocol!
    
    required init(view: StartViewControllerProtocol) {
        self.view = view
    }
}
