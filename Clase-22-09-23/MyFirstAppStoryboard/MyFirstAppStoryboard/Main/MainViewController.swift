//
//  ViewController.swift
//  MyFirstAppStoryboard
//
//  Created by Diplomado on 22/09/23.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var photoTypeSwitch: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleLabelField: UILabel!
    @IBOutlet weak var titleTextField: UITextField! {
        didSet {
            //            para lograr esto, necesita conformar el protocolo UITextField
            titleTextField.delegate = self
        }
    }
    @IBOutlet weak var shouldTitleChangeSwitch: UISwitch!
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        segue son las flechas del storyboard, indica para donde ir de una vista a otra
//        guard let destinationViewController = segue.destination as? ImageStackViewController else { return }
//        
//        destinationViewController.showDogs = photoTypeSwitch.isOn
//        
//        
////        titulos en el navigation bar
//        if shouldTitleChangeSwitch.isOn {
//            destinationViewController.title = titleTextField.text
//        }
//    }
    
    //el que inicia la accion es un UIButton
    @IBAction func nextButtonTapped(_ sender: UIButton) {
//        diferenciar los botones que usen esta funcion
        if sender.tag == 0 {
            //0 es el boton OpenInfo
            //            performSegue(withIdentifier: "SegueFromMainToInfo", sender: nil)
            segueToInfo()
            
        } else {
            segueToPhotos()
//            performSegue(withIdentifier: "SegueFromMainToPhotos", sender: nil)
        }
    }
    func segueToInfo(){
        let infoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InfoViewController")
        infoViewController.title = "Info"
        navigationController?.pushViewController(infoViewController, animated: true)
//        if shouldTitleChangeSwitch.isOn {
//            infoViewController.title = titleTextField.text
//        }
    }
    
    func segueToPhotos(){
        guard let photosViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageStackViewController") as? ImageStackViewController else {return}
        photosViewController.showDogs = photoTypeSwitch.isOn
        if shouldTitleChangeSwitch.isOn {
            photosViewController.title = titleTextField.text
        }
        //ya tiene la vista preparada, ahora hay que hacer el segue way
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
//    estos actions pueden ser ejecutados por distintos elementos
    @IBAction func photoTypeSwitchValueChanged(_ sender: UISwitch) {
        sender.isOn ? nextButton.setTitle("Dogs", for: .normal)
        : nextButton.setTitle("Cats", for: .normal)
    }
    
    @IBAction func titleTextFieldEditingChanged(_ sender: UITextField) {
        if (sender.text?.count ?? 0) == 0 {titleLabelField.text = "Custom title"}
        else {titleLabelField.text = sender.text}
    }
    
    @IBAction func shouldChangeTitleChanged(_ sender: UISwitch) {
        if !sender.isOn {
            titleLabelField.text = "Custom title not selected"
        }
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("1")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("2")
    }
    
    //hay mas cosas aqui pero no pude copiarlas

}

extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !shouldTitleChangeSwitch.isOn {return false}
        if string == "" {return true}
        if string.rangeOfCharacter(from: .alphanumerics) == nil 
            && string != " " {
            return false
        } else {
            return (textField.text?.count ?? 0) + string.count - range.length <= 10
        }
    }
}
