//
//  HomepageViewController.swift
//  Blackjack
//
//  Created by 黃郁雯 on 2022/11/18.
//

import UIKit

class HomepageViewController: UIViewController {

    //按照發牌的先後，命名 positionImageView 的編號
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
    
    
    //？為什麼無法在 class closure 內使用已經宣告好的變數，在 func 裡才行
    //let positionImageViewArray = [position1ImageView, position2ImageView, position3ImageView, position4ImageView]
    //index 為跑迴圈用的編號
    var index = -1
    var playerTotalCardFigure = 0
    var dealerTotalCardFigure = 0
    var playerWin = false
    var dealerWin = false
    
    
    //宣告變數給前一個頁面回傳的資料
    //？Int 要加 !
    var bet: Int!
    var moneyLeft: Int!
    var betImage = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        dealCard()
    }
    
    
    //重置畫面
    func updateUI(){
        
        //增加 ImageView 內間距
        //嘗試一
//        position1ImageView.image = UIImage().resizableImage(withCapInsets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), resizingMode: .stretch)
        
        //嘗試二
//        position1ImageView.contentMode = .scaleAspectFill
//        position1ImageView.image = UIImage().withAlignmentRectInsets(UIEdgeInsets(top: -100, left: 10, bottom: 20, right: 20))
        
//        let image = UIImage(named: "imagename")!
//        let imageView = UIImageView(image: image.imageWithInsets(insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)))
//                imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        
//        let image1 = UIImage(named: "10clubs_j")!
//        position1ImageView = UIImageView(image: image1.imageWithInsets(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
        
        //隱藏牌
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
        
        //讓按鈕還不能點擊
        standButton.isEnabled = false
        hitButton.isEnabled = false
        playAgainButton.isEnabled = false
        
        playerTotalCardFigureLabel.text = String(playerTotalCardFigure)
        dealerTotalCardFigureLabel.text = String(dealerTotalCardFigure)
        moneyLeftLabel.text = String(moneyLeft)
        betImageView.image = betImage
    }
    
    
    
    
    //計算牌的點數
    func countFigure(cardName: String, character: String) -> Int{
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
            if character == "player" {
                if (playerTotalCardFigure + 11) <= 21{
                    return 11
                }else{
                    return 1
                }
            }else{
                if (dealerTotalCardFigure + 11) <= 21{
                    return 11
                }else{
                    return 1
                }
            }
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
    
    //下注完即開始發牌
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
                            
                            //var randomImage = UIImage(named: "10clubs_j")!
//                            positionImageViewArray[index] = UIImageView(image: UIImage(named: "\(cardDataArray[positionNumber])")!.imageWithInsets(insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)))
                            
                            playerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber], character: "player")
                            playerTotalCardFigureLabel.text = String(playerTotalCardFigure)
                            
                            if judge21(figure: playerTotalCardFigure){
                                flop()
                            }
        
                        }else if index < (positionImageViewArray.count - 1) && index % 2 != 0{
                            positionImageViewArray[index]!.isHidden = false
                            let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
                            positionImageViewArray[index]!.image = UIImage(named: "\(cardDataArray[positionNumber])")
                            print(cardDataArray[positionNumber])
                            dealerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber], character: "dealer")
                            dealerTotalCardFigureLabel.text = String(dealerTotalCardFigure)
                      
                        }else if index == (positionImageViewArray.count - 1){
                            positionImageViewArray[index]!.isHidden = false
                            positionImageViewArray[index]!.image = UIImage(named: "backRed")
                        }else{
                            standButton.isEnabled = true
                            hitButton.isEnabled = true
                            timerDealcard.invalidate()
                            }
                    }
    }
    
    
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
        
        print("1\(position4ImageView.image!)")
        let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
        positionImageViewArray[index]?.isHidden = false
        positionImageViewArray[index]?.image = UIImage(named: "\(cardDataArray[positionNumber])")
        playerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber], character: "player")
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
                dealerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber], character: "dealer")
                dealerTotalCardFigureLabel.text = String(dealerTotalCardFigure)

                print("7\(position4ImageView.image!)")
                
                if judge21(figure: dealerTotalCardFigure){
                    print("9\(position4ImageView.image!)")
                   
                    dealerWin = true
                    timerFlop.invalidate()
                    gameover()
                }
            }else if num == 2{
                dealerPlay()
                timerFlop.invalidate()
            }
        }
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
                    
                    dealerTotalCardFigure += countFigure(cardName: cardDataArray[positionNumber], character: "dealer")
                    dealerTotalCardFigureLabel.text = String(dealerTotalCardFigure)
                    
                    if dealerTotalCardFigure > playerTotalCardFigure && dealerTotalCardFigure < 21 {
                        //resultLabel.text = "Dealer wins."
                        dealerWin = true
                        gameover()
                        timerDealerPlay.invalidate()
                    }else if judge21(figure: dealerTotalCardFigure){
                        //resultLabel.text = "Dealer wins."
                        if playerWin{
                            dealerWin = true
                        }else{
                            dealerWin = true
                        }
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
                    playerWin = true
                    gameover()
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
            moneyLeft += bet * 2
        }else if playerWin == true && dealerWin == true{
            //平手情況
            resultLabel.text = "Push."
            moneyLeft += bet
        }else{
            //莊家贏
            resultLabel.text = "Dealer wins."
        }
        moneyLeftLabel.text = String(moneyLeft)
        
//        perform(Selector("playAgain"), with: nil, afterDelay: 3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.playAgainButton.isEnabled = true
        }
        
    }
    
    //重新開始遊戲

}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}
