//
//  HomepageViewController.swift
//  Blackjack
//
//  Created by 黃郁雯 on 2022/11/18.
//

import UIKit

class HomepageViewController: UIViewController {

    @IBOutlet weak var position1ImageView: UIImageView!
    @IBOutlet weak var position2ImageView: UIImageView!
    @IBOutlet weak var position3ImageView: UIImageView!
    @IBOutlet weak var position4ImageView: UIImageView!
    @IBOutlet weak var position5ImageView: UIImageView!
    @IBOutlet weak var position6ImageView: UIImageView!
    @IBOutlet weak var position7ImageView: UIImageView!
    @IBOutlet weak var position8ImageView: UIImageView!
    @IBOutlet weak var position9ImageView: UIImageView!
    @IBOutlet weak var position10ImageView: UIImageView!
    @IBOutlet weak var betImageView: UIImageView!
    
    @IBOutlet weak var dealerTotalCardFigureLabel: UILabel!
    @IBOutlet weak var playerTotalCardFigureLabel: UILabel!
    @IBOutlet weak var moneyLeftLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    //為什麼無法在外面使用已經宣告好的變數，在 func 裡才行
    //let positionImageViewArray = [position1ImageView, position2ImageView, position3ImageView, position4ImageView]
    var index = -1
    var playerTotalCardFigure = 0
    var dealerTotalCardFigure = 0
    var playerWin = false
    var dealerWin = false
    var chip = 0
    var moneyLeft = 1000
    var betImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        dealCard()

    }
    
//    //將剩餘金額 moneyLeft 傳至 HomepageViewController
//    @IBSegueAction func passMoneyLeft(_ coder: NSCoder) -> HomepageViewController? {
//        let controller = HomepageViewController(coder: coder)
//        controller?.moneyLeft = moneyLeft
//        
//        return <#HomepageViewController(coder: coder)#>
//    }
    
    
    //下注完即開始發牌
    //起始畫面
    //加 self ?
    func updateUI(){
        position1ImageView.isHidden = true
        position2ImageView.isHidden = true
        position3ImageView.isHidden = true
        position4ImageView.isHidden = true
        position5ImageView.isHidden = true
        position6ImageView.isHidden = true
        position7ImageView.isHidden = true
        position8ImageView.isHidden = true
        position9ImageView.isHidden = true
        position10ImageView.isHidden = true
        
        standButton.isEnabled = false
        hitButton.isEnabled = false
        playAgainButton.isEnabled = false
        
        playerTotalCardFigureLabel.text = String(playerTotalCardFigure)
        dealerTotalCardFigureLabel.text = String(dealerTotalCardFigure)
        moneyLeftLabel.text = String(moneyLeft)
        betImageView.image = betImage
        
    }
    
    //計算牌的點數
    func countFigure(cardName: String) -> Int{
        if cardName.hasPrefix("2"){
            return 2
        }else if cardName.hasPrefix("3"){
            return 3
        }else if cardName.hasPrefix("4"){
            return 4
        }else if cardName.hasPrefix("5"){
            return 5
        }else if cardName.hasPrefix("6"){
            return 6
        }else if cardName.hasPrefix("7"){
            return 7
        }else if cardName.hasPrefix("8"){
            return 8
        }else if cardName.hasPrefix("9"){
            return 9
        }else if cardName.hasPrefix("10"){
            return 10
        }else{
            return 11
        }
    }
    
    //判斷牌是否超過 21 點
    func judgeBust(figure: Int) -> Bool{
        if figure > 21{
            return true
        }else{
            return false
        }
    }
    
    //判斷牌是否等於 21 點
    func judge21(figure: Int) -> Bool{
        if figure == 21{
            return true
        }else{
            return false
        }
    }
    
    //發牌
    func dealCard(){
        let positionImageViewArray = [position1ImageView, position2ImageView, position3ImageView, position4ImageView]
        var timerDealcard = Timer()
        
        //將var index = 0 移至 closure 外就要加 [self]
        timerDealcard = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ [self] (_) in
            index += 1
                        if index < (positionImageViewArray.count - 1) && index % 2 == 0{
                            positionImageViewArray[index]!.isHidden = false
                            let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
                            positionImageViewArray[index]!.image = UIImage(named: "\(cardDataArray[positionNumber])")
                            print(cardDataArray[positionNumber])
                            playerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber])
                            //index += 1
                            playerTotalCardFigureLabel.text = String(playerTotalCardFigure)
                            
                            if judge21(figure: playerTotalCardFigure){
                                flop()
                            }
        
                            //測試用 print(playerTotalCardFigure)
                        }else if index < (positionImageViewArray.count - 1) && index % 2 != 0{
                            positionImageViewArray[index]!.isHidden = false
                            let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
                            positionImageViewArray[index]!.image = UIImage(named: "\(cardDataArray[positionNumber])")
                            print(cardDataArray[positionNumber])
                            dealerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber])
                            //index += 1
                            //print(cpuTotalCardFigure)
                            dealerTotalCardFigureLabel.text = String(dealerTotalCardFigure)
                      
                        }else if index == (positionImageViewArray.count - 1){
                            print("xxx\(position4ImageView.image)")
                            positionImageViewArray[index]!.isHidden = false
                            positionImageViewArray[index]!.image = UIImage(named: "backRed")
    
                        }else{
                            standButton.isEnabled = true
                            hitButton.isEnabled = true
                            timerDealcard.invalidate()
                            }
                    }
        
        //嘗試二，每張牌沒有間隔時間
        //        let positionImageViewArray = [position1ImageView, position2ImageView, position3ImageView, position4ImageView]
        //        for positionImageView in positionImageViewArray{
        //            var timer = Timer()
        //            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false){(_) in
        //                let positon = "position\(num)Number"
        //                let positionNumber = int
        //                var position1Number = Int.random(in: 2...10)
        //                positionImageView!.image = UIImage(named: "\(position1Number)_of_clubs")
        //            }
        //        }
                
        
        //嘗試一
        //        for positon in 1...4{
        //            var timer = Timer()
        //            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false){ (_) in
        //                positon
        //            }
        //        }
        
    }
    
    //玩家選擇停牌或是拿牌
    //玩家選擇停牌
    @IBAction func playerStand(_ sender: UIButton) {
        print("4\(position4ImageView.image!)")
        //let cpuWinResult = cpuWin()
        standButton.isEnabled = false
        hitButton.isEnabled = false
        flop()
        print("14\(position4ImageView.image!)")
    }
    
    //玩家選擇拿牌，直到玩家停牌或是牌超過 21 點
    @IBAction func playerHit(_ sender: UIButton) {
        let positionImageViewArray = [position1ImageView, position2ImageView, position3ImageView, position4ImageView, position5ImageView, position6ImageView, position7ImageView]
        //測試用 print(index)
        
        print("1\(position4ImageView.image!)")
        let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
        positionImageViewArray[index]?.isHidden = false
        positionImageViewArray[index]?.image = UIImage(named: "\(cardDataArray[positionNumber])")
        playerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber])
        playerTotalCardFigureLabel.text = String(playerTotalCardFigure)
        index += 1
        
        if judgeBust(figure: playerTotalCardFigure){
            print("2\(position4ImageView.image!)")
            playerWin = false
            //resultLabel.text = "Player busts! Dealer wins."
            gameover()
        }else if judge21(figure: playerTotalCardFigure){
            print("3\(position4ImageView.image!)")
            playerWin = true
            flop()
        }
        //print(playerTotalCardFigure)
        
    }
    
    //翻開原本蓋著的牌
    func flop(){
        print("5\(position4ImageView.image)")
        var timerFlop = Timer()
        var num = 0
        timerFlop = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [self] (_) in
            print("6\(position4ImageView.image!)")
            num += 1
            if num == 1{
                
                let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
                position4ImageView.image = UIImage(named: "\(cardDataArray[positionNumber])")
                dealerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber])
                dealerTotalCardFigureLabel.text = String(dealerTotalCardFigure)

                print("7\(position4ImageView.image!)")
                
                if judge21(figure: dealerTotalCardFigure){
                    print("9\(position4ImageView.image!)")
                   
                    dealerWin = true
                    timerFlop.invalidate()
                    gameover()
                }
            }else if num == 2{
                print("10\(position4ImageView.image!)")
                dealerPlay()
                timerFlop.invalidate()
            }
        }
        print("13\(position4ImageView.image!)")
    }
    
        //電腦玩家決定停牌或是拿牌，直到分出勝負
        func dealerPlay(){
            print("11\(position4ImageView.image!)")
            let positionImageViewArray = [position1ImageView, position2ImageView, position3ImageView, position4ImageView, position5ImageView, position6ImageView, position7ImageView, position8ImageView, position9ImageView, position10ImageView]
            index = 6
            
            var timerDealerPlay = Timer()
            timerDealerPlay = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [self] (_) in
                index += 1
                
                if index < positionImageViewArray.count{
                    let positionNumber = Int.random(in: 0...(positionImageViewArray.count - 1))
                    positionImageViewArray[index]?.isHidden = false
                    positionImageViewArray[index]?.image = UIImage(named: "\(cardDataArray[positionNumber])")
                    
                    dealerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber])
                    dealerTotalCardFigureLabel.text = String(dealerTotalCardFigure)
                    
                    if dealerTotalCardFigure > playerTotalCardFigure && dealerTotalCardFigure < 21 {
                        //resultLabel.text = "Dealer wins."
                        dealerWin = true
                        gameover()
                        timerDealerPlay.invalidate()
                    }else if judge21(figure: dealerTotalCardFigure) && playerWin{
                        //resultLabel.text = "Dealer wins."
                        dealerWin = true
                        gameover()
                        timerDealerPlay.invalidate()
                    }else if judgeBust(figure: dealerTotalCardFigure){
                        //resultLabel.text = "Dealer busts. Player wins."
                        playerWin = true
                        gameover()
                        timerDealerPlay.invalidate()
                    }
                }else{
                    timerDealerPlay.invalidate()
                }
            }
        }
    
    func playAgain(){
        playAgainButton.isEnabled = true
    }
    
    //遊戲結束
    //計算玩家金額，金額太少跳出 alert
    func gameover(){
        standButton.isEnabled = false
        hitButton.isEnabled = false
        if playerWin == true && dealerWin == false{
            //玩家贏
            resultLabel.text = "PLayer wins."
            moneyLeft += chip * 2
        }else if playerWin == true && dealerWin == true{
            //平手情況
            resultLabel.text = "Push."
            moneyLeft += chip
        }else{
            //莊家贏
            resultLabel.text = "Dealer wins."
        }
        
//        perform(Selector("playAgain"), with: nil, afterDelay: 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.playAgainButton.isEnabled = true
        }
        
    }
    
    //重新開始遊戲
    

}
