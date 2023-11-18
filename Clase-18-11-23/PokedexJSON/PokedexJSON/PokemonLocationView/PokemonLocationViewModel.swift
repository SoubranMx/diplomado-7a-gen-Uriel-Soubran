//
//  PokemonLocationViewModel.swift
//  PokedexJSON
//
//  Created by Diplomado on 18/11/23.
//

import Foundation
import CoreLocation

protocol PokemonLocationViewModelDelegate: AnyObject {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D)
}

class PokemonLocationViewModel: NSObject {
    //    obtiene los datos de navegacion
    private let locationManager = CLLocationManager()
    private var userLocation: CLLocationCoordinate2D? {
        willSet {
            if let newValue {
                delegate?.updateUserLocation(with: newValue)
            }
        }
    }
    weak var delegate: PokemonLocationViewModelDelegate?
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension PokemonLocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {return}
        self.userLocation = currentLocation.coordinate
    }
}
