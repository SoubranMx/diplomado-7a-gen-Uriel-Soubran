//
//  ConfigurationViewController.swift
//  SecondFinal_RockPaperScissors
//
//  Created by Diplomado on 14/10/23.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var GameTypeControl: UISegmentedControl!
    @IBOutlet weak var RoundsView: UIView!
    @IBOutlet weak var PointsView: UIView!
    @IBOutlet weak var PlayerNameTextField: UITextField!
    @IBOutlet weak var PlayButton: UIButton!
    @IBOutlet weak var PointsPerWinTextField: UITextField!
    @IBOutlet weak var PointsPerLoseTextField: UITextField!
    @IBOutlet weak var PointsToWinTextField: UITextField!
    @IBOutlet weak var RoundsSlider: UISlider!
    @IBOutlet weak var RoundsCountLabel: UILabel!
    
    func initSetup(){
        RoundsView.isHidden = true
        PlayButton.isHidden = true
        RoundsCountLabel.text = "\(Int(RoundsSlider.value))"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }

    
    @IBAction func controlChanged(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0){
            RoundsView.isHidden = true
            PointsView.isHidden = false
        } else {
            RoundsView.isHidden = false
            PointsView.isHidden = true
        }
    }
    
    @IBAction func onSliderChange(_ sender: UISlider) {
        RoundsCountLabel.text = "\(Int(sender.value))"
        RoundsSlider.value = sender.value
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
