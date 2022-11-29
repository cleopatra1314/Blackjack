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
    
    @IBOutlet weak var dealerTotalCardFigureTextView: UITextView!
    @IBOutlet weak var playerTotalCardFigureTextView: UITextView!

    @IBOutlet weak var moneyLeftLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    
    //？為什麼無法在 class closure 內使用已經宣告好的變數，在 func 裡才行
    //let positionImageViewArray = [position1ImageView, position2ImageView, position3ImageView, position4ImageView]
    //index 為跑迴圈用的編號
    var index = 0
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
        //洗牌
        cardDataArray.shuffle()
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
//        position1ImageView.image = UIImage()?.withAlignmentRectInsets(UIEdgeInsets(top: 16, left: 4, bottom: 16, right: 4))
        
//        let image = UIImage(named: "imagename")!
//        let imageView = UIImageView(image: image.imageWithInsets(insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)))
//                imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        
//        let image1 = UIImage(named: "10clubs_j")!
//        position1ImageView = UIImageView(image: image1.imageWithInsets(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)))
        
        
        //牌的圓角
        position1ImageView.layer.cornerRadius = 2
        position2ImageView.layer.cornerRadius = 2
        position3ImageView.layer.cornerRadius = 2
        position4ImageView.layer.cornerRadius = 2
        position5ImageView.layer.cornerRadius = 2
        position6ImageView.layer.cornerRadius = 2
        position7ImageView.layer.cornerRadius = 2
        position8ImageView.layer.cornerRadius = 2
        position9ImageView.layer.cornerRadius = 2
        position10ImageView.layer.cornerRadius = 2
        
        //image 在 imageView 的縮放比例
        position1ImageView.contentMode = .scaleAspectFill
        position2ImageView.contentMode = .scaleAspectFill
        position3ImageView.contentMode = .scaleAspectFill
        position4ImageView.contentMode = .scaleAspectFill
        position5ImageView.contentMode = .scaleAspectFill
        position6ImageView.contentMode = .scaleAspectFill
        position7ImageView.contentMode = .scaleAspectFill
        position8ImageView.contentMode = .scaleAspectFill
        position9ImageView.contentMode = .scaleAspectFill
        position10ImageView.contentMode = .scaleAspectFill
        
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
        
        //牌點數總和顯示框
        playerTotalCardFigureTextView.text = String(playerTotalCardFigure)
        playerTotalCardFigureTextView.textColor = .white
        playerTotalCardFigureTextView.textContainerInset = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
        playerTotalCardFigureTextView.layer.cornerRadius = 4
        playerTotalCardFigureTextView.layer.borderWidth = 0.8
        playerTotalCardFigureTextView.layer.borderColor = CGColor(gray: 1, alpha: 1)
        playerTotalCardFigureTextView.backgroundColor = .clear
        
        dealerTotalCardFigureTextView.text = String(dealerTotalCardFigure)
        dealerTotalCardFigureTextView.textColor = .white
        dealerTotalCardFigureTextView.textContainerInset = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
        dealerTotalCardFigureTextView.layer.cornerRadius = 4
        dealerTotalCardFigureTextView.layer.borderWidth = 0.8
        dealerTotalCardFigureTextView.layer.borderColor = CGColor(gray: 1, alpha: 1)
        dealerTotalCardFigureTextView.backgroundColor = .clear
        
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
        //withTimeInterval 時間間隔從一開始執行就開始算；repeat: false -> 時間到不會消失
        timerDealcard = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){ [self] (_) in
    
                        if index < (positionImageViewArray.count - 1) && index % 2 == 0{
                            positionImageViewArray[index]!.isHidden = false
//                            let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
//                            positionImageViewArray[index]!.image = UIImage(named: "\(cardDataArray[positionNumber])")
//                            positionImageViewArray[index]?.contentMode = .scaleAspectFill
                            positionImageViewArray[index]!.image = UIImage(named: "\(cardDataArray[index])")?.imageWithInsets(insets: UIEdgeInsets(top: 16, left: 6, bottom: 16, right: 6))
                            playerTotalCardFigure += countFigure(cardName: cardDataArray[index], character: "player")
                            playerTotalCardFigureTextView.text = String(playerTotalCardFigure)
                            
                            if judge21(figure: playerTotalCardFigure){
                                resultLabel.text = "Player 21!"
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                    self.resultLabel.text = ""
                                }
                                //不能在這邊就先執行 flop，會跟蓋牌動作打在一起
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
//                                    self.flop()
//                                }
                                //index += 1
                            }
                            index += 1
                        }else if index < (positionImageViewArray.count - 1) && index % 2 != 0{
                            positionImageViewArray[index]!.isHidden = false
//                            let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
//                            positionImageViewArray[index]!.image = UIImage(named: "\(cardDataArray[positionNumber])")
                            positionImageViewArray[index]!.image = UIImage(named: "\(cardDataArray[index])")?.imageWithInsets(insets: UIEdgeInsets(top: 16, left: 6, bottom: 16, right: 6))
                            dealerTotalCardFigure += countFigure(cardName: cardDataArray[index], character: "dealer")
                            dealerTotalCardFigureTextView.text = String(dealerTotalCardFigure)
                            index += 1
                        }else if index == (positionImageViewArray.count - 1){
                            positionImageViewArray[index]!.isHidden = false
                            positionImageViewArray[index]!.image = UIImage(named: "backRed")
                            index += 1
                        }else{
                            timerDealcard.invalidate()
                            
                            if judge21(figure: playerTotalCardFigure){
                                flop()
                            }
                            startMotion()
                            }
                    }
    }
    
    
    //玩家選擇停牌
    @IBAction func playerStand(_ sender: UIButton) {
        stopMotion()
        flop()
    }
    
    
    //玩家選擇拿牌，直到玩家停牌或是牌超過 21 點
    @IBAction func playerHit(_ sender: UIButton) {
        let positionImageViewArray = [position1ImageView, position2ImageView, position3ImageView, position4ImageView, position5ImageView, position6ImageView, position7ImageView]
    
        //將隨機選牌概念改成，在一開始 array shuffle()洗牌
        //let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
        positionImageViewArray[index]?.isHidden = false
        positionImageViewArray[index]?.image = UIImage(named: "\(cardDataArray[index])")?.imageWithInsets(insets: UIEdgeInsets(top: 16, left: 6, bottom: 16, right: 6))
        playerTotalCardFigure += countFigure(cardName: cardDataArray[index], character: "player")
        playerTotalCardFigureTextView.text = String(playerTotalCardFigure)
        index += 1
        
        if judgeBust(figure: playerTotalCardFigure){
            stopMotion()
            playerWin = false
            resultLabel.text = "Player busts!"
            //延遲執行 func
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.gameover()
            }
            
        }else if judge21(figure: playerTotalCardFigure){
            stopMotion()
            playerWin = true

            resultLabel.text = "Player 21!"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.resultLabel.text = ""
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.flop()
            }
        }else if index == 7{
            hitButton.isEnabled = false
        }
    }
    
    
    //莊家翻開原本蓋著的牌
    func flop(){
        var timerFlop = Timer()
        var num = 0
        //indexofCoverCard 為發牌的順序號-1
        let indexOfCoverCard = 3
        
        timerFlop = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [self] (_) in
            num += 1
            if num == 1{
                
                //let positionNumber = Int.random(in: 0...(cardDataArray.count - 1))
                position4ImageView.image = UIImage(named: "\(cardDataArray[indexOfCoverCard])")?.imageWithInsets(insets: UIEdgeInsets(top: 16, left: 6, bottom: 16, right: 6))
                dealerTotalCardFigure += countFigure(cardName: cardDataArray[indexOfCoverCard], character: "dealer")
                dealerTotalCardFigureTextView.text = String(dealerTotalCardFigure)
                
                if judge21(figure: dealerTotalCardFigure) || dealerTotalCardFigure > playerTotalCardFigure{
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

            let positionImageViewArray = [position1ImageView, position2ImageView, position3ImageView, position4ImageView, position5ImageView, position6ImageView, position7ImageView, position8ImageView, position9ImageView, position10ImageView]
            index = 6
            
            var timerDealerPlay = Timer()
            timerDealerPlay = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ [self] (_) in
                index += 1
                
                if index < positionImageViewArray.count{
                    //let positionNumber = Int.random(in: 0...(positionImageViewArray.count - 1))
                    positionImageViewArray[index]?.isHidden = false
                    positionImageViewArray[index]?.image = UIImage(named: "\(cardDataArray[index])")?.imageWithInsets(insets: UIEdgeInsets(top: 16, left: 6, bottom: 16, right: 6))
                    
                    dealerTotalCardFigure += countFigure(cardName: cardDataArray[index], character: "dealer")
                    dealerTotalCardFigureTextView.text = String(dealerTotalCardFigure)
                    
                    if dealerTotalCardFigure > playerTotalCardFigure && dealerTotalCardFigure < 21 {
                        dealerWin = true
                        gameover()
                        timerDealerPlay.invalidate()
                    }else if judge21(figure: dealerTotalCardFigure){
                        if playerWin{
                            dealerWin = true
                        }else{
                            dealerWin = true
                        }
                        gameover()
                        timerDealerPlay.invalidate()
                    }else if judgeBust(figure: dealerTotalCardFigure){
                        timerDealerPlay.invalidate()
                        resultLabel.text = "Dealer busts."
                        playerWin = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.resultLabel.text = ""
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            self.gameover()
                        }
                    }
                }else{
                    timerDealerPlay.invalidate()
                    playerWin = true
                    gameover()
                }
            }
        }
    
    
    //開始操作按鍵
    func startMotion(){
        standButton.isEnabled = true
        hitButton.isEnabled = true
    }
    
    
    //停止操作按鍵
    func stopMotion(){
        standButton.isEnabled = false
        hitButton.isEnabled = false
    }
    
    //遊戲結束
    //計算玩家金額，金額太少跳出 alert
    func gameover(){
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.playAgainButton.isEnabled = true
        }
    }
    
    
    //重新開始遊戲
    func playAgain(){
        playAgainButton.isEnabled = true
    }

}


//讓 imageView 內的 image 有內間距
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
