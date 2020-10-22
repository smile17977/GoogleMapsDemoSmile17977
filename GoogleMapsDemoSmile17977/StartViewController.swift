//
//  StartViewController.swift
//  GoogleMapsDemoSmile17977
//
//  Created by Kir Pir on 20.10.2020.
//

import UIKit
import CoreLocation

protocol StartViewControllerProtocol {
}

class StartViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet var showMapButton: UIButton!
    
    // MARK: Properties
    private let locationManager = CLLocationManager()
    private var presenter: StartPresenterProtocol!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = StartPresenter(view: self)
        
        setupView()
        getCurrentLocation()
    }
    
    // MARK: UI
    private func setupView() {
        setButton(for: showMapButton, "Показать карту",  .white)
        view.backgroundColor = .white
    }
    
    private func setButton(for button: UIButton,
                           _ title: String,
                           _ titleColor: UIColor) {
        button.layer.cornerRadius = 10
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = .systemBlue
    }
    
    // MARK: Location
    private func getCurrentLocation() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
}

// MARK: CLLocationManagerDelegate
extension StartViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager
                .location?
                .coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
}

// MARK: StartViewControllerProtocol
extension StartViewController: StartViewControllerProtocol {
}

