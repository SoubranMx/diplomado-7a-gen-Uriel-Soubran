//
//  ConfigurationViewController.swift
//  SecondFinal_RockPaperScissors
//
//  Created by Diplomado on 14/10/23.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var GameTypeControl: UISegmentedControl!
    @IBOutlet weak var RoundsStackView: UIStackView!
    @IBOutlet weak var PointsStackView: UIStackView!
    @IBOutlet weak var PlayerNameTextField: UITextField!
    @IBOutlet weak var PlayButton: UIButton!
    //since these textFields are custom controlled, they need to be delegated
    @IBOutlet weak var PointsPerWinTextField: UITextField! {
        didSet {
            PointsPerWinTextField.delegate = self
        }
    }
    @IBOutlet weak var PointsPerLoseTextField: UITextField! {
        didSet {
            PointsPerLoseTextField.delegate = self
        }
    }
    @IBOutlet weak var PointsToWinTextField: UITextField! {
        didSet {
            PointsToWinTextField.delegate = self
        }
    }
    @IBOutlet weak var RoundsSlider: UISlider!
    @IBOutlet weak var RoundsCountLabel: UILabel!
    
    //To not have errors when writting the value of selectedMode, such as "Points" over "points", or miss spelled text, make it an enum
    enum mode: String{
        case points
        case rounds
    }
    var selectedMode: mode = .points;
    
    
    
    func initSetup(){
        RoundsStackView.isHidden = true
        PlayButton.tintColor = UIColor.systemOrange
        PlayButton.isHidden = true
        PlayButton.tintColor = UIColor.systemOrange
        RoundsCountLabel.text = "\(Int(RoundsSlider.value))"
        PlayerNameTextField.text = ""
        PointsPerWinTextField.text = ""
        PointsPerLoseTextField.text = ""
        PointsToWinTextField.text = ""
        selectedMode = .points
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }

    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            RoundsStackView.isHidden = true
            PointsStackView.isHidden = false
            selectedMode = .points
        } else {
            RoundsStackView.isHidden = false
            PointsStackView.isHidden = true
            selectedMode = .rounds
        }
        decidePlayButtonVisibility()
    }
    
    @IBAction func onSliderChange(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
        RoundsCountLabel.text = String(Int(roundedValue))
    }
    
    func decidePlayButtonVisibility() {
        if(selectedMode == .points) {
            if((PointsPerWinTextField.text?.count ?? 0) > 0 && (PointsPerLoseTextField.text?.count ?? 0) > 0 && (PointsToWinTextField.text?.count ?? 0) > 0 && (PlayerNameTextField.text?.count ?? 0) > 0) {
                PlayButton.isHidden = false
            } else {
                PlayButton.isHidden = true
            }
        } else {
            if ((PlayerNameTextField.text?.count ?? 0) > 0) {
                PlayButton.isHidden = false
            } else {
                PlayButton.isHidden = true
            }
        }
    }
    
    @IBAction func onPlayerNameTextChange(_ sender: UITextField) {
        decidePlayButtonVisibility()
    }
    
    @IBAction func segueButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            segueToInfo()
        } else {
            segueToGame()
        }
    }
    
    func segueToInfo() {
        print("Segue way to Info/rules")
         // Present View "Modally"
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
    
    func segueToGame() {
        print("Segue way to Game")
    }

}

extension ConfigurationViewController: UITextFieldDelegate {
//    to know when the textField is being edited
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            PointsPerWinTextField.text = textField.text
            break
        case 1:
            PointsPerLoseTextField.text = textField.text
            break
        case 2:
            PointsToWinTextField.text = textField.text
            break
        default:
            return
        }
        
        decidePlayButtonVisibility()
    }
    
//    to control what kind of text the textField accepts
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        allow backspace to edit
        if string == "" {return true}
//        only allow digits
        if let x = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits) {
            return true
        } else {
            return false
        }
    }
}
