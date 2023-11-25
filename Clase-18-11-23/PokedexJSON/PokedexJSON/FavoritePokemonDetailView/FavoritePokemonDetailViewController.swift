//
//  FavoritePokemonDetailViewController.swift
//  PokedexJSON
//
//  Created by Diplomado on 25/11/23.
//

import UIKit
import PhotosUI

class FavoritePokemonDetailViewController: UIViewController {
    
    let viewModel: FavoritePokemonDetailModel
    private lazy var pokemonImageView: UIImageView = {
        let pokemonImage = UIImage(systemName: "cat")
        let pokemonImageView = UIImageView(image: pokemonImage)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        return pokemonImageView
    }()
    
    var currentAnimation = 0
    
    
    init(pokemon: Pokemon) {
        viewModel = FavoritePokemonDetailModel(pokemon: pokemon)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        var animationButtonConfiguration = UIButton.Configuration.filled()
        animationButtonConfiguration.title = "Animate"
        
        let animationButton = UIButton(configuration: animationButtonConfiguration)
        animationButton.translatesAutoresizingMaskIntoConstraints = false
        animationButton.addTarget(self, action: #selector(didTapAnimatedButton), for: .touchUpInside)
        
        var captureButtonConfiguration = UIButton.Configuration.tinted()
        captureButtonConfiguration.title = "Capture"
        let captureButton = UIButton(configuration: captureButtonConfiguration)
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        captureButton.addTarget(self, action: #selector(didTapCaptureButton), for: .touchUpInside)
        
        var selfieButtonConfiguration = UIButton.Configuration.plain()
        selfieButtonConfiguration.title = "Take Selfie"
        let selfieButton = UIButton(configuration: selfieButtonConfiguration)
        selfieButton.addTarget(self, action: #selector(didTapSelfieButton), for: .touchUpInside)
        selfieButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let actionsStackView = UIStackView()
        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        actionsStackView.axis = .vertical
        actionsStackView.spacing = 8
        
        actionsStackView.addArrangedSubview(animationButton)
        actionsStackView.addArrangedSubview(captureButton)
        actionsStackView.addArrangedSubview(selfieButton)
        
        view.addSubview(pokemonImageView)
        view.addSubview(actionsStackView)
        
        NSLayoutConstraint.activate([
            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            actionsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
    }
    
    @objc
    private func didTapSelfieButton(){
        
        #if targetEnvironment(simulator)
        var photoPickerConfiguration = PHPickerConfiguration()
        photoPickerConfiguration.filter = .images
        photoPickerConfiguration.selectionLimit = 1 //if 0, las que el usuario quiera
        let photoPicker = PHPickerViewController(configuration: photoPickerConfiguration)
        photoPicker.delegate = self
        present(photoPicker, animated: true)
        #else
        //        activar la camara, iOS ya tiene una escena
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
        #endif
    }
    
    @objc
    private func didTapCaptureButton(){
        navigationController?.pushViewController(CaptureSimViewController(), animated: true)
    }
    
    @objc
    private func didTapAnimatedButton() {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5) {
            switch self.currentAnimation {
            case 0:
                self.pokemonImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            case 1: self.pokemonImageView.transform = CGAffineTransform.identity //regresa el original
            
            case 2: self.pokemonImageView.transform = CGAffineTransform(translationX: 0, y: 100)
            case 3: self.pokemonImageView.transform = CGAffineTransform.identity
            
            case 4: self.pokemonImageView.transform = CGAffineTransform(rotationAngle: .pi)
            case 5: self.pokemonImageView.transform = CGAffineTransform.identity
            
            case 6: self.pokemonImageView.backgroundColor = .purple
            case 7: self.pokemonImageView.backgroundColor = .clear
                
            default: break
            }
        } completion: { _ in
            self.currentAnimation += 1
            self.currentAnimation = self.currentAnimation > 7 ? 0 : self.currentAnimation
        }
    }
}

extension FavoritePokemonDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {return}
        print(image.size)
    }
}

extension FavoritePokemonDetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        
        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            guard let image = image as? UIImage, error == nil else {return}
            print(image.size)
        }
    }
}
