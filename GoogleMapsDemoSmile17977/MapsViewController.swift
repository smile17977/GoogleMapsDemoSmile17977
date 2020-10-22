//
//  MapsViewController.swift
//  GoogleMapsDemoSmile17977
//
//  Created by Kir Pir on 20.10.2020.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils

protocol MapsViewControllerProtocol {
    func createMarkers(for users: [User])
}

class MapsViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK: Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private var clusterManager: GMUClusterManager!
    private var presenter: MapsPresenterProtocol!

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MapsPresenter.init(view: self)
        presenter.getUsers()
        
        setupView()
        setupMapView()
        setupMapStyle()
        setupClusterManager()
    }
    
    // MARK: UI
    private func setupView() {
        view.backgroundColor = .white
        title = "Google maps"
    }
    private func setupMapView() {
        let camera = GMSCameraPosition.camera(withLatitude: 55.75,
                                              longitude: 37.60,
                                              zoom: 5.0)
        mapView.camera = camera
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    private func setupClusterManager() {
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView,
                                                 clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView,
                                           algorithm: algorithm,
                                           renderer: renderer)
        clusterManager.setMapDelegate(self)
    }
    
    private func setupMapStyle() {
        if let styleURL = Bundle.main.url(forResource: "gmsDarkStyle",
                                          withExtension: "json") {
          mapView.mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
        } else {
          NSLog("Unable to find style.json")
        }
    }
}

// MARK: MapsViewControllerProtocol
extension MapsViewController: MapsViewControllerProtocol {
    func createMarkers(for users: [User]) {
        DispatchQueue.main.async {
            for user in users {
                guard let latitude = user.latitude else { return }
                guard let longitude = user.longitude else { return }
                let currentLocation = CLLocationCoordinate2DMake(latitude,
                                                                 longitude)
                let marker = GMSMarker(position: currentLocation)
                marker.title = user.clientCode
                self.clusterManager.add(marker)
            }
            self.clusterManager.cluster()
        }
    }
}

// MARK: GMSMapViewDelegate
extension MapsViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
      mapView.animate(toLocation: marker.position)
      if let _ = marker.userData as? GMUCluster {
        mapView.animate(toZoom: mapView.camera.zoom + 1)
        NSLog("Did tap cluster")
        return true
      }
      NSLog("Did tap marker")
      return false
    }
}
