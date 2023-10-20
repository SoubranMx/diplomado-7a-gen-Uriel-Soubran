//
//  GameViewController.swift
//  SecondFinal_RockPaperScissors
//
//  Created by Diplomado on 14/10/23.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var pointsCounterLabel: UILabel!
    @IBOutlet weak var machineSelectionLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    @IBOutlet weak var resetGameButton: UIButton!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    var gameHistory = [String]()
    var playersName = String()
    var gameMode: ConfigurationViewController.gameMode? = nil
    var selectedOption: handOption = .paper
    var pointsCounter: Int = Int()
    var pointsPerWin = Int()
    var pointsPerLose = Int()
    var pointsToWin = Int()
    var goalRounds = Int()
    var currentRound = Int()
    var currentResult: compareResult = .tie;
    
    enum compareResult: String {
        case win
        case lose
        case tie
    }
    
    enum handOption: String {
        case paper
        case scissor
        case rock
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    @IBAction func historyButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "SegueFromGameToHistory", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare segue way to History")
        guard let historyViewController = segue.destination as? HistoryViewController else {return}
        
        var textForHistoryView = ""
        var roundIndex = 1
        gameHistory.forEach {
            item in
            textForHistoryView += "\(roundIndex): \(item)\n"
            roundIndex += 1
        }
        historyViewController.outsideHistoryText = textForHistoryView
        historyViewController.outsideModalTitle = gameMode == .rounds ? "\(playersName)'s Game History\nMode: Rounds" : "\(playersName)'s Game History\nMode: Points"
        
    }
    
    func compareSelections(playerSelection: handOption, machineSelection: handOption) -> compareResult {
        if(playerSelection == .paper && machineSelection == .paper) { return .tie }
        else if(playerSelection == .paper && machineSelection == .rock) { return .win }
        else if(playerSelection == .paper && machineSelection == .scissor) { return .lose }
        else if(playerSelection == .rock && machineSelection == .paper) { return .lose }
        else if(playerSelection == .rock && machineSelection == .rock) { return .tie }
        else if(playerSelection == .rock && machineSelection == .scissor) { return .win }
        else if(playerSelection == .scissor && machineSelection == .paper) { return .win }
        else if(playerSelection == .scissor && machineSelection == .rock) { return .lose }
        else { return .tie }
    }

    @IBAction func onPlayerButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 { selectedOption = .rock}
        else if sender.tag == 1 { selectedOption = .paper }
        else { selectedOption = .scissor }
        
        var machineSelection: handOption = .paper
        let randomInt = Int.random(in: 0..<3)
        switch randomInt {
        case 0: 
            machineSelection = .rock
            machineSelectionLabel.text = "👊🏼"
            break
        case 1: machineSelection = .paper
            machineSelectionLabel.text = "🖐🏼"
            break
        case 2: machineSelection = .scissor
            machineSelectionLabel.text = "✌🏼"
            break
        default: machineSelection = .paper
            machineSelectionLabel.text = "👊🏼"
            break
        }
        machineSelectionLabel.isHidden = false
        
        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorButton.isEnabled = false
        nextRoundButton.isEnabled = true
        
        let comparisonResult = compareSelections(playerSelection: selectedOption, machineSelection: machineSelection)
        resolvePoints(forResult: comparisonResult)
    }
    
    func resolvePoints(forResult result: compareResult) {
//        change bgColor for both .points or .rounds and show result label
        if result == .win {
            view.backgroundColor = .systemGreen
            resultLabel.text = "\(playersName), you won this round!"
        }
        else if result == .lose {
            view.backgroundColor = .systemRed
            resultLabel.text = "\(playersName), you lose this round!"
        }
        else {
            view.backgroundColor = .systemBrown
            resultLabel.text = "\(playersName), it's a tie!"
        }
        resultLabel.isHidden = false
        
//        change labels to show points / rounds
        if(gameMode == .points) {
            if(result == .win) {
                pointsCounter += pointsPerWin
                gameHistory.append("\(playersName) won, \(pointsPerWin) added, total points = \(pointsCounter)")
            }
            else if (result == .lose) {
                pointsCounter = pointsCounter - pointsPerLose < 0 ? 0 : pointsCounter - pointsPerLose
                gameHistory.append("\(playersName) lose, \(pointsPerLose) discounted, total points = \(pointsCounter)")
            }
            else {
                gameHistory.append("\(playersName) tied, total points = \(pointsCounter)")
            }
            
            if( pointsCounter >= pointsToWin) { showWinAlert() }
        } else {
            if result == .win {
                currentRound += 1
                gameHistory.append("\(playersName) won this round, win rounds = \(currentRound)")
            } else if result == .lose {
                gameHistory.append("\(playersName) lost this round")
            } else {
                gameHistory.append("\(playersName) got a tie in this round.")
            }
            if currentRound >= goalRounds { showWinAlert() }
        }
    }
    
    func showWinAlert(){
        updateVarsOnWin()
        let dialogMessage = UIAlertController(title: "You won!", message: "Congrats on winning, \(playersName). Your score is saved.", preferredStyle: .alert)
        // Create OK button with action handler
         let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             print("Ok button tapped")
          })
         
         //Add OK button to a dialog message
         dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
        nextRoundButton.isEnabled = false
    }
    
    func updateVarsOnWin() {
        pointsCounterLabel.text = gameMode == .points ? String(pointsCounter) : String(currentRound)
    }
    
    @IBAction func onNextRoundTapped(_ sender: UIButton) {
        view.backgroundColor = .systemGray
        machineSelectionLabel.isHidden = true
        rockButton.isEnabled = true
        paperButton.isEnabled = true
        scissorButton.isEnabled = true
        pointsCounterLabel.text = gameMode == .points ? String(pointsCounter) : String(currentRound)
        resultLabel.isHidden = true
        nextRoundButton.isEnabled = false
    }
    
    @IBAction func onResetGameTapped(_ sender: UIButton) {
        setup()
    }
    
    func setup(){
        pointsLabel.text = gameMode == .points ? "Current points" : "Win rounds"
        view.backgroundColor = .systemGray
        machineSelectionLabel.isHidden = true
        rockButton.isEnabled = true
        paperButton.isEnabled = true
        scissorButton.isEnabled = true
        nextRoundButton.isEnabled = true
        pointsCounter = 0
        currentRound = 0
        pointsCounterLabel.text = String(Int(pointsCounter))
        currentResult = .tie
        resultLabel.text = ""
        resultLabel.isHidden = true
        resultLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        resultLabel.textColor = .white
    }

}
