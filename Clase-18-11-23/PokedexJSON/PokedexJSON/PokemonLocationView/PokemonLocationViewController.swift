//
//  PokemonLocationViewController.swift
//  pokedex2
//
//  Created by Diplomado on 18/11/23.
//

import UIKit
import MapKit

class PokemonLocationViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        return mapView
    }()
    
    var viewModel: PokemonLocationViewModel

    private lazy var dismissButton: UIButton = {
        var dismissButtonConfiguration = UIButton.Configuration.filled()
        dismissButtonConfiguration.buttonSize = .medium
        dismissButtonConfiguration.baseForegroundColor = .secondaryLabel
        dismissButtonConfiguration.baseBackgroundColor = .secondarySystemBackground
        dismissButtonConfiguration.image = UIImage(systemName: "xmark.circle") //app SF Symbols, by Apple, you can view in there all the systemName icons
        dismissButtonConfiguration.cornerStyle = .capsule
        let dismissButton = UIButton(configuration: dismissButtonConfiguration)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        return dismissButton
    }()

    init(){
        viewModel = PokemonLocationViewModel()
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    required init(coder: NSCoder) {
        fatalError("Some error")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .red
        view.addSubview(mapView)
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    @objc
    func dismissModal() {
        dismiss(animated: true)
    }
}

extension PokemonLocationViewController: PokemonLocationViewModelDelegate {
    func updateUserLocation(with coordinate: CLLocationCoordinate2D) {
        let userLocationPin = MapKit.MKPointAnnotation()
        userLocationPin.coordinate = coordinate
        mapView.addAnnotation(userLocationPin)
        
        //        to make zoom
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        mapView.region = mapRegion
    }
    
    func shouldShowNoPermissionsAlert() {
        let alert = UIAlertController(title: "Location Permission", message: "Please update the location permission in Settings", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default){
            [weak self] _ in
            self?.dismissModal()
        }
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
}
