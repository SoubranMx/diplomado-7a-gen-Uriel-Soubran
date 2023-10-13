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
            firstCaptionedImage.imageView.image = UIImage(named: "dog-1")
            secondCaptionedImage.imageView.image = UIImage(named: "dog-2")
            thirdCaptionedImage.imageView.image = UIImage(named: "dog-3")
        } else {
            firstCaptionedImage.imageView.image = UIImage(named: "cat-1")
            secondCaptionedImage.imageView.image = UIImage(named: "cat-2")
            thirdCaptionedImage.imageView.image = UIImage(named: "cat-3")
        }
    }
}
