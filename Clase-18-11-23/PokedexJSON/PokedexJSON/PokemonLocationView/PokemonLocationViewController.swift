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
        mapView.showsUserLocation = true //muestra la ubicacion del usuario ? ver la documentacion, sin necesidad de usar el delegate.
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
    
    private lazy var showPokemonLocationButton: UIButton = {
        var pokemonLocationButtonConfiguration = UIButton.Configuration.filled()
        pokemonLocationButtonConfiguration.title = "Show pokemon location"
//        pokemonLocationButtonConfiguration.buttonSize = .medium
//        pokemonLocationButtonConfiguration.baseForegroundColor = .secondaryLabel
//        pokemonLocationButtonConfiguration.baseBackgroundColor = .secondarySystemBackground
        let pokemonLocationButton = UIButton(configuration: pokemonLocationButtonConfiguration)
        pokemonLocationButton.translatesAutoresizingMaskIntoConstraints = false
        pokemonLocationButton.addTarget(self, action: #selector(didTapShowLocationButton), for: .touchUpInside)
        return pokemonLocationButton
    }()
    
    private lazy var showDirectionsButton: UIButton = {
        var showDirectionsButtonConfig = UIButton.Configuration.filled()
        showDirectionsButtonConfig.title = "Show Directiosn"
        let showDirectionsButton = UIButton(configuration: showDirectionsButtonConfig)
        showDirectionsButton.translatesAutoresizingMaskIntoConstraints = false
        showDirectionsButton.addTarget(self, action: #selector(didTapShowDirectionsButton), for: .touchUpInside)
        return showDirectionsButton
    }()
    
    init(pokemon: Pokemon){
        viewModel = PokemonLocationViewModel(pokemon: pokemon)
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        mapView.delegate = self
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
        if let _ = viewModel.pokemonLatitude {
            let actionsStackView = UIStackView()
            actionsStackView.axis = .vertical
            actionsStackView.spacing = 8
            actionsStackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(actionsStackView)
            
            NSLayoutConstraint.activate([
                actionsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                actionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                actionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                
            ])
        }
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        ])
    }
    
    @objc
    func dismissModal() {
        dismiss(animated: true)
    }
    
    @objc
    func didTapShowLocationButton() {
        viewModel.didTapShowPokemonLocationButton()
    }
    @objc
    func didTapShowDirectionsButton() {
        viewModel.didTapShowDirectionsButton()
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
    
    func showPokemonLocation(with coordinate: CLLocationCoordinate2D) {
        let pokemonAnnotation = MKPointAnnotation()
        pokemonAnnotation.coordinate = coordinate
        
        mapView.addAnnotation(pokemonAnnotation)
        
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        mapView.region = mapRegion
    }
    
    func showDirections(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) {
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: from))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: to))
        
        directionRequest.transportType = .walking
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { response, error in
            guard error == nil, let response, let route = response.routes.first else {return}
            self.mapView.addOverlay(route.polyline)
        }
    }
}

extension PokemonLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .cyan
        render.lineWidth = 8
        return render
    }
}
