//
//  ImageStackViewController.swift
//  MyFirstAppStoryboard
//
//  Created by Diplomado on 29/09/23.
//

import UIKit

class ImageStackViewController: UIViewController {
    
    var showDogs = false
// IBOutlet es una manera de relacionar elementos del Storyboard con variables de código. Se puede arrastrar el inicio de la variable hacia el elemento que quieres relacionar.
    
    @IBOutlet weak var thirdCaptionedImage: CaptionedImage!
    @IBOutlet weak var secondCaptionedImage: CaptionedImage!
    @IBOutlet weak var firstCaptionedImage: CaptionedImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//      UIImage es un contenedor de imagenes
//      Crea una imagen teniendo lo que se encuentra dentro de assets con el nombre dog-1
        if showDogs {
            firstCaptionedImage.setContent(image: "dog-1", caption: "Dog-1")
            secondCaptionedImage.setContent(image: "dog-2", caption: nil)
            thirdCaptionedImage.setContent(image: "dog-3", caption: "Dog-3")
        } else {
            firstCaptionedImage.setContent(image: "cat-1", caption: "Cat-1")
            secondCaptionedImage.setContent(image: "cat-2", caption: "Cat-2")
            thirdCaptionedImage.setContent(image: "cat-3", caption: "Cat-3")
//            firstCaptionedImage.imageView.image = UIImage(named: "cat-1")
//            secondCaptionedImage.imageView.image = UIImage(named: "cat-2")
//            thirdCaptionedImage.imageView.image = UIImage(named: "cat-3")
        }
    }
    
    @IBAction func segueToShare(_ sender: UIBarButtonItem) {
        let shareViewController = ShareModalViewController()
        present(shareViewController, animated: true)
    }
}
