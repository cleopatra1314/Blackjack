//
//  placeBetViewController.swift
//  Blackjack
//
//  Created by 黃郁雯 on 2022/11/19.
//

import UIKit

class placeBetViewController: UIViewController {

    @IBOutlet weak var chip1000Button: UIButton!
    @IBOutlet weak var chip2000Button: UIButton!
    @IBOutlet weak var chip3000Button: UIButton!
    
    @IBOutlet weak var moneyLeftLabel: UILabel!
    
    var moneyLeft = 10000
    var bet = 0
    var betImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLeftLabel.text = String(moneyLeft)
        // Do any additional setup after loading the view.
    }
    
    //將剩餘金額 moneyLeft 傳至 HomepageViewController
    @IBSegueAction func passMoneyLeft(_ coder: NSCoder) -> HomepageViewController? {
        let controller = HomepageViewController(coder: coder)
        controller?.moneyLeft = moneyLeft
        controller?.betImage = betImage
     
        return controller
    }
    
    
    @IBAction func calculateMoney(_ sender: UIButton) {
        bet = Int(sender.currentTitle!)!
        moneyLeft -= bet
        moneyLeftLabel.text = String(moneyLeft)
        //betButton 的 title 調為 attributed 就無法讀取其 currentTitle，會顯示 button 而非數字
        //print(sender.currentTitle)
        
        betImage = sender.currentBackgroundImage!
        
        performSegue(withIdentifier: "betToDeal", sender: UIButton.self)
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
