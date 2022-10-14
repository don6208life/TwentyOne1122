//
//  TwentyOnePlayViewController.swift
//  TwentyOne
//
//  Created by DonDesigner on 2022/10/28.
//

import UIKit
import AVFoundation

class TwentyOnePlayViewController: UIViewController
{
// MARK: - Botton Outlet
    
    @IBOutlet weak var button1000: UIButton!
    @IBOutlet weak var button500: UIButton!
    @IBOutlet weak var button100: UIButton!
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var noRaiseBtn: UIButton!
    @IBOutlet weak var raiseBtn: UIButton!
    
// MARK: - Label Outlet
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var betScoreLabel: UILabel!
    
    @IBOutlet weak var bookmakerPointLabel: UILabel!
    @IBOutlet weak var playerPointLabel: UILabel!
 
// MARK: - Attributes Setup
  
    var playerPoint: Int = 0
    var bookmakerPoint: Int = 0
    
    var score: Int = 0
    var betScore: Int = 0
    
    var raise: Bool = false
    var noRaise: Bool = false
    var playStatus: Bool = false
    
    var cards = [Card]()
    var timer = Timer()
    var count = 5
    
    var playerCard1: Card!
    var playerCard2: Card!
    var playerCard3: Card!
    var playerCard4: Card!
    var playerCard5: Card!
    
    let playerCardView1 = UIImageView()
    let playerCardView2 = UIImageView()
    let playerCardView3 = UIImageView()
    let playerCardView4 = UIImageView()
    let playerCardView5 = UIImageView()
    
    var playerAddCardCount = 0
    var bookmakerAddCardCount = 0
    
    var bookmakerCard1: Card!
    var bookmakerCard2: Card!
    var bookmakerCard3: Card!
    var bookmakerCard4: Card!
    var bookmakerCard5: Card!
    
    let bookmakerCardView1 = UIImageView()
    let bookmakerCardView2 = UIImageView()
    let bookmakerCardView3 = UIImageView()
    let bookmakerCardView4 = UIImageView()
    let bookmakerCardView5 = UIImageView()
    
    let cardBakerView = UIImageView()
    
    var playerCard1ViewPositionX: NSLayoutConstraint?
    var playerCard1ViewPositionY: NSLayoutConstraint?
    //-------------------------------------------------
    var playerCard2ViewPositionX: NSLayoutConstraint?
    var playerCard2ViewPositionY: NSLayoutConstraint?
    //-------------------------------------------------
    var playerCard3ViewPositionX: NSLayoutConstraint?
    var playerCard3ViewPositionY: NSLayoutConstraint?
    //-------------------------------------------------
    var playerCard4ViewPositionX: NSLayoutConstraint?
    var playerCard4ViewPositionY: NSLayoutConstraint?
    //-------------------------------------------------
    var playerCard5ViewPositionX: NSLayoutConstraint?
    var playerCard5ViewPositionY: NSLayoutConstraint?
    //=================================================
    var bookmakerCard1ViewPositionX: NSLayoutConstraint?
    var bookmakerCard1ViewPositionY: NSLayoutConstraint?
    //-------------------------------------------------
    var bookmakerCard2ViewPositionX: NSLayoutConstraint?
    var bookmakerCard2ViewPositionY: NSLayoutConstraint?
    //-------------------------------------------------
    var bookmakerCard3ViewPositionX: NSLayoutConstraint?
    var bookmakerCard3ViewPositionY: NSLayoutConstraint?
    //-------------------------------------------------
    var bookmakerCard4ViewPositionX: NSLayoutConstraint?
    var bookmakerCard4ViewPositionY: NSLayoutConstraint?
    //-------------------------------------------------
    var bookmakerCard5ViewPositionX: NSLayoutConstraint?
    var bookmakerCard5ViewPositionY: NSLayoutConstraint?
    //-------------------------------------------------
    var cardBakerViewPositionX: NSLayoutConstraint?
    var cardBakerViewPositionY: NSLayoutConstraint?
    
    let player = AVPlayer()
    
    
   
// MARK: - ViewDidLoad
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        cardBakerUI()
        betBtnDisable()
        raiseAndNoRaiseDisable()
        bookmakerPointLabel.isHidden = true
        playerPointLabel.isHidden = true
        resultLabel.text = "請按PLAY開始"
    }
    //畫面橫向
    override var supportedInterfaceOrientations:
    UIInterfaceOrientationMask
    {
        .landscape
    }

// MARK: - Button Function
    
    @IBAction func playBtn(_ sender: UIButton)
    {
        playStatus = true
        betBtnEnable()
        raiseAndNoRaiseDisable()
        sender.isEnabled = false
        score = 10000
        scoreLabel.text = "目前積分:\(score)"
        
        let suits = ["♠️", "♥️", "♦️", "♣️"]
        let ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        
        for _ in 1...2
        {
            for suit in suits
            {
                for rank in ranks
                {
                    let card = Card(suit: suit, rank: rank)
                    cards.append(card)
                }
            }
        }
        resultLabel.text = "請下注"
    }
    
    @IBAction func noRaiseBtn(_ sender: UIButton)
    {
        noRaise = true
    }
    
    @IBAction func raiseBtn(_ sender: UIButton)
    {
        raise = true
    }
    
    
    @IBAction func btn1000(_ sender: UIButton)
    {
        if score < 1000
        {
            resultLabel.isHidden = false
            resultLabel.text = "您的積分不足"
        }
        else
        {
            betScore = 1000
            betScoreLabel.text = "Bet:1000"
            score = score - betScore
            scoreLabel.text = "目前積分:\(score)"
            play()
        }
    }
    
    @IBAction func btn500(_ sender: UIButton)
    {
       if score < 500
        {
           resultLabel.isHidden = false
           resultLabel.text = "您的積分不足"
       }
        else
        {
            betScore = 500
            betScoreLabel.text = "Bet:500"
            score = score - betScore
            scoreLabel.text = "目前積分:\(score)"
            play()
        }
    }
    
    @IBAction func btn100(_ sender: UIButton)
    {
       
        betScore = 100
        betScoreLabel.text = "Bet:100"
        score = score - betScore
        scoreLabel.text = "目前積分:\(score)"
        play()
        
    }
    @IBAction func quit(_ sender: UIButton)
    {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "CasinoViewController") as? CasinoViewController
        {
            present(controller, animated: true) {
                let fileUrl = Bundle.main.url(forResource: "Casino", withExtension: "mp3")!
                let playItem = AVPlayerItem(url: fileUrl)
                controller.looper = AVPlayerLooper(player: controller.player, templateItem: playItem)
                controller.player.play()
            }

        }
    }
    //MARK: - Custom Function
    
    func betBtnEnable()
    {
        button100.isEnabled = true
        button500.isEnabled = true
        button1000.isEnabled = true
        button100.isHidden = false
        button500.isHidden = false
        button1000.isHidden = false
    }
    
    func betBtnDisable()
    {
        button100.isEnabled = false
        button500.isEnabled = false
        button1000.isEnabled = false
        button100.isHidden = true
        button500.isHidden = true
        button1000.isHidden = true
    }
    
    func raiseAndNoRaiseEnable()
    {
        raiseBtn.isEnabled = true
        noRaiseBtn.isEnabled = true
        raiseBtn.isHidden = false
        noRaiseBtn.isHidden = false
    }
    
    func raiseAndNoRaiseDisable()
    {
        raiseBtn.isEnabled = false
        noRaiseBtn.isEnabled = false
        raiseBtn.isHidden = true
        noRaiseBtn.isHidden = true
    }
    
    func pointCalculate(rank: String) -> Int
    {
        var point = 0
        switch rank
        {
            case "A":
                point = 11
            case "K":
                point = 10
            case "Q":
                point = 10
            case "J":
                point = 10
            default:
                point = Int(rank)!
        }
        return point
    }
    
    func play()
    {
        betBtnDisable()
        resultLabel.text = ""
        resultLabel.isHidden = true
        playerPoint = 0
        bookmakerPoint = 0
        
        cards.shuffle()
        playerCard1 = cards[0]
        playerCard2 = cards[2]
        playerCard3 = cards[4]
        playerCard4 = cards[6]
        playerCard5 = cards[8]
        bookmakerCard1 = cards[1]
        bookmakerCard2 = cards[3]
        bookmakerCard3 = cards[5]
        bookmakerCard4 = cards[7]
        bookmakerCard5 = cards[9]

        self.playerCard1UI()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
        {
            //=====玩家第一張牌=====
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
            {
                self.licensingEffect()
                self.playerCard1ViewPositionY?.constant = 290
                self.playerCard1ViewPositionX?.constant = 500
                self.view.layoutIfNeeded()
            }
            //=====莊家第一張牌=====
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
            {
                self.bookmakerCard1UI()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                {
                    self.licensingEffect()
                    self.bookmakerCard1ViewPositionX?.constant = 500
                    self.bookmakerCard1ViewPositionY?.constant = 30
                    self.view.layoutIfNeeded()
                }
                //=====玩家第二張牌=====
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                {
                    self.playerCard2UI()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                {
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                    {
                        self.licensingEffect()
                        self.playerCard2ViewPositionY?.constant = 290
                        self.playerCard2ViewPositionX?.constant = 450
                        self.view.layoutIfNeeded()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                        {
                            self.bookmakerCard2UI()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                        {
                            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                            {
                                self.playerCardView2.image = UIImage(named: "\(self.playerCard2.suit)\(self.playerCard2.rank)")
                            }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                                {
                                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                                    {
                                        self.playerCardView1.image = UIImage(named: "\(self.playerCard1.suit)\(self.playerCard1.rank)")
                                    }
                                    let playerCard1Point = self.pointCalculate(rank: self.playerCard1.rank)
                                    let playerCard2Point = self.pointCalculate(rank: self.playerCard2.rank)
                                    self.playerPoint = playerCard1Point + playerCard2Point
                                    //若玩家前兩張牌為"A","A"為"1"點
                                    if self.playerCard1.rank == "A" && self.playerCard2.rank == "A"
                                    {
                                        self.playerPoint -= 20
                                    }
                                    self.playerPointLabel.isHidden = false
                                    self.playerPointLabel.text = "玩家:\(self.playerPoint)點"
                                }
                           // }
                            //=====莊家第二張牌=====
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                            {
                                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                                {
                                    self.licensingEffect()
                                    self.bookmakerCard2ViewPositionX?.constant = 450
                                    self.bookmakerCard2ViewPositionY?.constant = 30
                                    self.view.layoutIfNeeded()
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                                {
                                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                                    {
                                        self.bookmakerCardView2.image = UIImage(named: "\(self.bookmakerCard2.suit)\(self.bookmakerCard2.rank)")
                                    }
                                    let bookmakerCard1Point = self.pointCalculate(rank: self.bookmakerCard1.rank)
                                    let bookmakerCard2Point = self.pointCalculate(rank: self.bookmakerCard2.rank)
                                    self.bookmakerPoint = bookmakerCard1Point + bookmakerCard2Point
                                    //若莊家前兩張牌為A,A變為"1"點
                                    if self.bookmakerCard1.rank == "A" && self.bookmakerCard2.rank == "A"
                                    {
                                        self.bookmakerPoint -= 20
                                    }
                                    if self.playerPoint == 21
                                    {
                                        self.blackJackEffect()
                                        self.bookmakerCardView1.image = UIImage(named: "\(self.bookmakerCard1.suit)\(self.bookmakerCard1.rank)")
                                        self.bookmakerPointLabel.isHidden = false
                                        self.bookmakerPointLabel.text = "莊家:\(self.bookmakerPoint)點"
                                        self.resultLabel.isHidden = false
                                        self.resultLabel.text = "Black Jack"
                                        self.raiseAndNoRaiseDisable()
                                        self.score = self.score + self.betScore * 2
                                        self.scoreLabel.text = "目前積分:\(self.score)"
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 6)
                                        {
                                            self.clearUI()
                                            self.resultLabel.isHidden = false
                                            self.resultLabel.text = "請下注"
                                            self.playerPointLabel.isHidden = true
                                            self.playerPointLabel.text = ""
                                            self.bookmakerPointLabel.isHidden = true
                                            self.bookmakerPointLabel.text = ""
                                            self.betScoreLabel.text = ""
                                            self.betBtnEnable()
                                        }
                                    }
                                    else
                                    {
                                        self.raiseCountDown()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func raiseCountDown()
    {
        raise = false
        noRaise = false
        self.raiseAndNoRaiseEnable()
        count = 5
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.resultLabel.isHidden = false
            self.resultLabel.text = "是否加牌:\(self.count)秒"
            self.count -= 1
            if self.count < 0 || self.raise == true || self.noRaise == true
            {
                timer.invalidate()
                
                if self.raise == true
                {
//                    self.raise = false
//                    self.noRaise = false
                    self.resultLabel.text = ""
                    self.resultLabel.isHidden = true
                    self.playerAddCardCount += 1
                    self.playerAddCard()
                }
                else if self.noRaise == true
                {
                    if self.playerPoint < self.bookmakerPoint
                    {
                        self.resultLabel.text = ""
                        self.resultLabel.isHidden = true
                        self.raiseAndNoRaiseDisable()
                        self.result()
                    }
                    else
                    {
                        self.resultLabel.text = ""
                        self.resultLabel.isHidden = true
                        self.bookmakerAddCard()
                    }
                }
                else if self.count < 0 && self.raise == false && self.noRaise == false
                {
                    if self.playerPoint < self.bookmakerPoint
                    {
                        self.resultLabel.text = ""
                        self.resultLabel.isHidden = true
                        self.raiseAndNoRaiseDisable()
                        self.result()
                    }
                    else
                    {
                        self.resultLabel.text = ""
                        self.resultLabel.isHidden = true
                        self.bookmakerAddCard()
                    }
                    
                }
          }
        })
        
    }
    
    func playerAddCard()
    {
        var playerAChange = false
        switch playerAddCardCount
        {
        case 1:
            self.playerCard3UI()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
            {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                {
                    self.licensingEffect()
                    self.playerCard3ViewPositionY?.constant = 290
                    self.playerCard3ViewPositionX?.constant = 400
                    self.view.layoutIfNeeded()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                {
                    self.playerCardView3.image = UIImage(named: "\(self.playerCard3.suit)\(self.playerCard3.rank)")
                    self.playerPoint = self.playerPoint + self.pointCalculate(rank: self.playerCard3.rank)
                    print("player add card1 point:\(self.playerCard3.rank);\(self.playerPoint)")
                    if self.playerPoint == 21
                    {
                        self.result()
                    }
                    else if self.playerCard3.rank == "A"
                    {
                        if self.playerCard1.rank == "A" && self.playerCard2.rank == "A"
                        {
                            self.playerPoint -= 10
                            playerAChange = true
                            
                        }
                        else if self.playerCard1.rank == "A"
                        {
                            self.playerPoint -= 20
                            playerAChange = true
                            
                        }
                        else if self.playerCard2.rank == "A"
                        {
                            self.playerPoint -= 20
                            playerAChange = true
                            
                        }
                        else if self.playerPoint > 21
                        {
                            self.playerPoint -= 10
                            playerAChange = true
                            if self.playerPoint <= 10
                            {
                                self.playerPoint += 10
                                playerAChange = false
                            }
                        }
                    }
                    else if (self.playerCard1.rank == "A" || self.playerCard2.rank == "A") && self.playerPoint > 21
                    {
                        self.playerPoint -= 10
                        playerAChange = true
                        if self.playerPoint <= 10
                        {
                            self.playerPoint += 10
                            playerAChange = false
                        }
                    }
                    self.playerPointLabel.text = "玩家:\(self.playerPoint)點"
//                    if self.playerPoint == 21
//                    {
//                        self.result()
//                    }
                    if self.playerPoint < 21
                    {
                        self.raiseCountDown()
                    }
                    else
                    {
                        self.result()
                    }
                }
            }
        case 2:
            self.playerCard4UI()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
            {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                {
                    self.licensingEffect()
                    self.playerCard4ViewPositionY?.constant = 290
                    self.playerCard4ViewPositionX?.constant = 350
                    self.view.layoutIfNeeded()
                }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                    {
                        self.playerCardView4.image = UIImage(named: "\(self.playerCard4.suit)\(self.playerCard4.rank)")
                        self.playerPoint = self.playerPoint + self.pointCalculate(rank: self.playerCard4.rank)
                        print("player add card2 point:\(self.playerCard4.rank);\(self.playerPoint)")
                        if self.playerPoint == 21
                        {
                            self.result()
                        }
                        else if self.playerCard4.rank == "A"
                        {
                            if self.playerCard1.rank != "A" && self.playerCard2.rank != "A" && self.playerCard3.rank != "A" && self.playerPoint > 21
                            {
                                self.playerPoint -= 10
                                playerAChange = true
                            }
                            else if self.playerCard1.rank == "A" && self.playerCard2.rank != "A" && self.playerCard3.rank != "A"
                            {
                                if self.playerPoint < 21
                                {
                                    self.playerPoint -= 10
                                    playerAChange = true
                                }
                                else
                                {
                                    self.playerPoint -= 20
                                    playerAChange = true
                                }
                                
                            }
                            else if self.playerCard1.rank != "A" && self.playerCard2.rank == "A" && self.playerCard3.rank != "A"
                            {
                                if self.playerPoint < 21
                                {
                                    self.playerPoint -= 10
                                    playerAChange = true
                                }
                                else
                                {
                                    self.playerPoint -= 20
                                    playerAChange = true
                                }
                                
                            }
                            else if self.playerCard1.rank != "A" && self.playerCard2.rank != "A" && self.playerCard3.rank == "A"
                            {
                                if self.playerPoint < 21
                                {
                                    self.playerPoint -= 10
                                    playerAChange = true
       
                                }
                                else
                                {
                                    self.playerPoint -= 20
                                    playerAChange = true
                                }
                            }
                        }
                        else if self.playerCard1.rank == "A" || self.playerCard2.rank == "A" || self.playerCard3.rank == "A"
                        {
                            if self.playerCard1.rank != "A" && self.playerCard2.rank != "A"
                            {
                                if playerAChange == false && self.playerPoint > 21
                                {
                                    self.playerPoint -= 10
                                    playerAChange = true
                                }
                            }
                            else if self.playerCard1.rank != "A" && self.playerCard3.rank != "A"
                            {
                                if playerAChange == false && self.playerPoint > 21
                                {
                                    self.playerPoint -= 10
                                    playerAChange = true
                                }
                            }
                            else if self.playerCard2.rank != "A" && self.playerCard3.rank != "A"
                            {
                                if playerAChange ==  false && self.playerPoint > 21
                                {
                                    self.playerPoint -= 10
                                    playerAChange = true
                                }
                            }
                        }
                        self.playerPointLabel.text = "玩家:\(self.playerPoint)點"
                        
//                        if self.playerPoint == 21
//                        {
//                            self.result()
//                        }
                        if self.playerPoint < 21
                        {
                            self.raiseCountDown()
                        }
                        else
                        {
                            self.result()
                        }
                    }
            }
        case 3:
            self.playerCard5UI()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
            {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                {
                    self.licensingEffect()
                    self.playerCard5ViewPositionY?.constant = 290
                    self.playerCard5ViewPositionX?.constant = 300
                    self.cardBakerUI()
                    self.view.layoutIfNeeded()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                {
                    self.playerCardView5.image = UIImage(named: "\(self.playerCard5.suit)\(self.playerCard5.rank)")
                    self.playerPoint = self.playerPoint + self.pointCalculate(rank: self.playerCard5.rank)
                   
                    if self.playerPoint == 21
                    {
                        print("player add card3 point:\(self.playerCard5.rank);\(self.playerPoint)")
                        self.result()
                    }
                    else if self.playerCard5.rank == "A"
                    {
                        if self.playerCard1.rank != "A" && self.playerCard2.rank != "A" && self.playerCard3.rank != "A" && self.playerCard4.rank != "A" && self.playerPoint > 21
                        {
                            self.playerPoint -= 10
                            playerAChange = true
                        }
                        else if self.playerCard1.rank == "A" && self.playerCard2.rank != "A" && self.playerCard3.rank != "A" && self.playerCard4.rank != "A"
                        {
                            if self.playerPoint < 21
                            {
                                self.playerPoint -= 10
                                playerAChange = true
                            }
                            else
                            {
                                self.playerPoint -= 20
                                playerAChange = true
                            }
                        }
                        else if self.playerCard1.rank != "A" && self.playerCard2.rank == "A" && self.playerCard3.rank != "A" && self.playerCard4.rank != "A"
                        {
                            if self.playerPoint < 21
                            {
                                self.playerPoint -= 10
                                playerAChange = true
                            }
                            else
                            {
                                self.playerPoint -= 20
                                playerAChange = true
                            }
                        }
                        else if self.playerCard1.rank != "A" && self.playerCard2.rank != "A" && self.playerCard3.rank == "A" && self.playerCard4.rank != "A"
                        {
                            if self.playerPoint < 21
                            {
                                self.playerPoint -= 10
                                playerAChange = true
                            }
                            else
                            {
                                self.playerPoint -= 20
                                playerAChange = true
                            }
                        }
                        else if self.playerCard1.rank != "A" && self.playerCard2.rank != "A" && self.playerCard3.rank != "A" && self.playerCard4.rank == "A"
                        {
                            if self.playerPoint < 21
                            {
                                self.playerPoint -= 10
                                playerAChange = true
                            }
                            else
                            {
                                self.playerPoint -= 20
                                playerAChange = true
                            }
                        }
                    }
                    else if self.playerCard1.rank == "A" || self.playerCard2.rank == "A" || self.playerCard3.rank == "A" || self.playerCard4.rank == "A"
                    {
                        if self.playerCard1.rank != "A" && self.playerCard2.rank != "A" && self.playerCard3.rank != "A"
                        {
                            if playerAChange == false && self.playerPoint > 21
                            {
                                self.playerPoint -= 10
                                playerAChange = true
                            }
                        }
                        else if self.playerCard1.rank != "A" && self.playerCard2.rank != "A" && self.playerCard4.rank != "A"
                        {
                            if playerAChange == false && self.playerPoint > 21
                            {
                                self.playerPoint -= 10
                                playerAChange = true
                            }
                        }
                        else if self.playerCard1.rank != "A" && self.playerCard3.rank != "A" && self.playerCard4.rank != "A"
                        {
                            if playerAChange == false && self.playerPoint > 21
                            {
                                self.playerPoint -= 10
                                playerAChange = true
                            }
                        }
                        else if self.playerCard2.rank != "A" && self.playerCard3.rank != "A" && self.playerCard4.rank != "A"
                        {
                            if playerAChange == false && self.playerPoint > 21
                            {
                                self.playerPoint -= 10
                                playerAChange = true
                            }
                        }
                    }
                    self.playerPointLabel.text = "玩家:\(self.playerPoint)點"
//                    if self.playerPoint == 21
//                    {
//                        self.result()
//                    }
                    if self.playerPoint < 21
                    {
                        self.raiseAndNoRaiseDisable()
                        self.bookmakerCardView1.image = UIImage(named: "\(self.bookmakerCard1.suit)\(self.bookmakerCard1.rank)")
                        self.bookmakerPointLabel.isHidden = false
                        self.bookmakerPointLabel.text = "莊家:\(self.bookmakerPoint)點"
                        self.playerWinEffect()
                        self.resultLabel.isHidden = false
                        self.resultLabel.text = "Player Win"
                        self.score = self.score + self.betScore * 2
                        self.scoreLabel.text = "目前積分:\(self.score)"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 6)
                        {
                            self.playerCardView1.image = nil
                            if self.playerCardView1.tag == 101
                            {
                                self.playerCardView1.removeFromSuperview()
                            }
                            self.playerCardView2.image = nil
                            if self.playerCardView2.tag == 102
                            {
                                self.playerCardView2.removeFromSuperview()
                            }
                            self.clearUI()
                            self.resultLabel.isHidden = false
                            self.resultLabel.text = "請下注"
                            self.playerPointLabel.text = ""
                            self.playerPointLabel.isHidden = true
                            self.bookmakerPointLabel.text = ""
                            self.bookmakerPointLabel.isHidden = true
                            self.betBtnEnable()
                        }
                    }
                    else
                    {
                        self.result()
                    }
                }
            }
            default:
                break
            
        }
    }
    
    func bookmakerAddCard()
    {
        var bookmakerAChange = false
        raiseAndNoRaiseDisable()
        bookmakerCardView1.image = UIImage(named: "\(bookmakerCard1.suit)\(bookmakerCard1.rank)")
        self.bookmakerPointLabel.isHidden = false
        bookmakerPointLabel.text = "莊家:\(bookmakerPoint)點"
        if bookmakerPoint < 17
        {
            bookmakerAddCardCount += 1
            bookmakerCard3UI()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
            {
                UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                {
                    self.licensingEffect()
                    self.bookmakerCard3ViewPositionX?.constant = 400
                    self.bookmakerCard3ViewPositionY?.constant = 30
                    self.view.layoutIfNeeded()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                {
                    self.bookmakerCardView3.image = UIImage(named: "\(self.bookmakerCard3.suit)\(self.bookmakerCard3.rank)")
                    self.bookmakerPoint = self.bookmakerPoint + self.pointCalculate(rank: self.bookmakerCard3.rank)
                    print("bookmaker add card1 point:\(self.bookmakerCard3.rank);\(self.bookmakerPoint)")
                    if self.bookmakerPoint == 21
                    {
                        self.result()
                        print("莊家第三張牌21")
                    }
                    else if self.bookmakerCard3.rank == "A"
                    {
                        if self.bookmakerCard1.rank == "A" && self.bookmakerCard2.rank == "A"
                        {
                            self.bookmakerPoint -= 10
                            bookmakerAChange = true
                        }
                        else if self.bookmakerCard1.rank == "A"
                        {
                            self.bookmakerPoint -= 20
                            bookmakerAChange = true
                        }
                        else if self.bookmakerCard2.rank == "A"
                        {
                            self.bookmakerPoint -= 20
                            bookmakerAChange = true
                        }
                        else if self.bookmakerPoint > 21
                        {
                            self.bookmakerPoint -= 10
                            bookmakerAChange = true
                            if self.bookmakerPoint <= 10
                            {
                                self.bookmakerPoint += 10
                                bookmakerAChange = false
                            }
                        }
                    }
                    else if (self.bookmakerCard1.rank == "A" || self.bookmakerCard2.rank == "A") && self.bookmakerPoint > 21
                    {
                        self.bookmakerPoint -= 10
                        bookmakerAChange = true
                        if self.bookmakerPoint <= 10
                        {
                            self.bookmakerPoint += 10
                            bookmakerAChange = false
                        }
                    }
                    self.bookmakerPointLabel.text = "莊家:\(self.bookmakerPoint)點"
                    
                    if self.bookmakerPoint < 17
                    {
                        self.bookmakerCard4UI()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                        {
                            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                            {
                                self.licensingEffect()
                                self.bookmakerCard4ViewPositionX?.constant = 350
                                self.bookmakerCard4ViewPositionY?.constant = 30
                                self.view.layoutIfNeeded()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                            {
                                self.bookmakerCardView4.image = UIImage(named: "\(self.bookmakerCard4.suit)\(self.bookmakerCard4.rank)")
                                self.bookmakerAddCardCount += 1
                                self.bookmakerPoint = self.bookmakerPoint + self.pointCalculate(rank: self.bookmakerCard4.rank)
                                print("bookmaker add card2 point:\(self.bookmakerCard4.rank);\(self.bookmakerPoint)")
                                if self.bookmakerPoint == 21
                                {
                                    self.result()
                                    print("莊家第四張牌21")
                                }
                                else if self.bookmakerCard4.rank == "A"
                                {
                                    if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank != "A" && self.bookmakerPoint > 21
                                    {
                                        self.bookmakerPoint -= 10
                                        bookmakerAChange = true
                                    }
                                    else if self.bookmakerCard1.rank == "A" && self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank != "A"
                                    {
                                        if self.bookmakerPoint < 21
                                        {
                                            self.bookmakerPoint -= 10
                                            bookmakerAChange = true
                                        }
                                        else
                                        {
                                            self.bookmakerPoint -= 20
                                            bookmakerAChange = true
                                        }
                                        
                                    }
                                    else if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank == "A" && self.bookmakerCard3.rank != "A"
                                    {
                                        if self.bookmakerPoint < 21
                                        {
                                            self.bookmakerPoint -= 10
                                            bookmakerAChange = true
                                        }
                                        else
                                        {
                                            self.bookmakerPoint -= 20
                                            bookmakerAChange = true
                                        }
                                    }
                                    else if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank == "A"
                                    {
                                        if self.bookmakerPoint < 21
                                        {
                                            self.bookmakerPoint -= 10
                                            bookmakerAChange = true
                                        }
                                        else
                                        {
                                            self.bookmakerPoint -= 20
                                            bookmakerAChange = true
                                        }
                                    }
                                }
                                else if self.bookmakerCard1.rank == "A" || self.bookmakerCard2.rank == "A" || self.bookmakerCard3.rank == "A"
                                {
                                    if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank != "A"
                                    {
                                        if bookmakerAChange == false && self.bookmakerPoint > 21
                                        {
                                            self.bookmakerPoint -= 10
                                            bookmakerAChange = true
                                        }
                                    }
                                    else if self.bookmakerCard1.rank != "A" && self.bookmakerCard3.rank != "A"
                                    {
                                        if bookmakerAChange == false && self.bookmakerPoint > 21
                                        {
                                            self.bookmakerPoint -= 10
                                            bookmakerAChange = true
                                        }
                                    }
                                    else if self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank != "A"
                                    {
                                        if bookmakerAChange == false && self.bookmakerPoint > 21
                                        {
                                            self.bookmakerPoint -= 10
                                            bookmakerAChange = true
                                        }
                                    }
                                }
                                
                                self.bookmakerPointLabel.text = "莊家:\(self.bookmakerPoint)點"
                                
                                if self.bookmakerPoint < 17
                                {
                                    self.bookmakerCard5UI()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                                    {
                                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0)
                                        {
                                            self.licensingEffect()
                                            self.bookmakerCard5ViewPositionX?.constant = 300
                                            self.bookmakerCard5ViewPositionY?.constant = 30
                                            self.view.layoutIfNeeded()
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
                                        {
                                            self.bookmakerCardView5.image = UIImage(named: "\(self.bookmakerCard5.suit)\(self.bookmakerCard5.rank)")
                                            self.bookmakerAddCardCount += 1
                                            self.bookmakerPoint = self.bookmakerPoint + self.pointCalculate(rank: self.bookmakerCard5.rank)
                                            print("bookmaker add card3 point:\(self.bookmakerCard5.rank);\(self.bookmakerPoint)")
                                            if self.bookmakerPoint == 21
                                            {
                                                self.result()
                                                print("莊家第五張牌21")
                                            }
                                            else if self.bookmakerCard4.rank == "A"
                                            {
                                                if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank != "A" && self.bookmakerCard4.rank != "A" && self.bookmakerPoint > 21
                                                {
                                                    self.bookmakerPoint -= 10
                                                    bookmakerAChange = true
                                                }
                                                else if self.bookmakerCard1.rank == "A" && self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank != "A" && self.bookmakerCard4.rank != "A"
                                                {
                                                    if self.bookmakerPoint > 21
                                                    {
                                                        self.bookmakerPoint -= 10
                                                        bookmakerAChange = true
                                                    }
                                                    else
                                                    {
                                                        self.bookmakerPoint -= 20
                                                        bookmakerAChange = true
                                                    }
                                                }
                                                else if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank == "A" && self.bookmakerCard3.rank != "A" && self.bookmakerCard4.rank != "A"
                                                {
                                                    if self.bookmakerPoint > 21
                                                    {
                                                        self.bookmakerPoint -= 10
                                                        bookmakerAChange = true
                                                    }
                                                    else
                                                    {
                                                        self.bookmakerPoint -= 20
                                                        bookmakerAChange = true
                                                    }
                                                }
                                                else if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank == "A" && self.bookmakerCard4.rank != "A"
                                                {
                                                    if self.bookmakerPoint > 21
                                                    {
                                                        self.bookmakerPoint -= 10
                                                        bookmakerAChange = true
                                                    }
                                                    else
                                                    {
                                                        self.bookmakerPoint -= 20
                                                        bookmakerAChange = true
                                                    }
                                                }
                                                else if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank != "A" && self.bookmakerCard4.rank == "A"
                                                {
                                                    if self.bookmakerPoint > 21
                                                    {
                                                        self.bookmakerPoint -= 10
                                                        bookmakerAChange = true
                                                    }
                                                    else
                                                    {
                                                        self.bookmakerPoint -= 20
                                                        bookmakerAChange = true
                                                    }
                                                }
                                            }
                                            else if self.bookmakerCard1.rank == "A" || self.bookmakerCard2.rank == "A" || self.bookmakerCard3.rank == "A" || self.bookmakerCard4.rank == "A"
                                            {
                                                if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank != "A"
                                                {
                                                    if bookmakerAChange == false && self.bookmakerPoint > 21
                                                    {
                                                        self.bookmakerPoint -= 10
                                                        bookmakerAChange = true
                                                    }
                                                }
                                                else if self.bookmakerCard1.rank != "A" && self.bookmakerCard2.rank != "A" && self.bookmakerCard4.rank != "A"
                                                {
                                                    if bookmakerAChange == false && self.bookmakerPoint > 21
                                                    {
                                                        self.bookmakerPoint -= 10
                                                        bookmakerAChange = true
                                                    }
                                                }
                                                else if self.bookmakerCard1.rank != "A" && self.bookmakerCard3.rank != "A" && self.bookmakerCard4.rank != "A"
                                                {
                                                    if bookmakerAChange == false && self.bookmakerPoint > 21
                                                    {
                                                        self.bookmakerPoint -= 10
                                                        bookmakerAChange = true
                                                    }
                                                }
                                                else if self.bookmakerCard2.rank != "A" && self.bookmakerCard3.rank != "A" && self.bookmakerCard4.rank != "A" 
                                                {
                                                    if bookmakerAChange == false && self.bookmakerPoint > 21
                                                    {
                                                        self.bookmakerPoint -= 10
                                                        bookmakerAChange = true
                                                    }
                                                }
                                            }
                                            self.bookmakerPointLabel.text = "莊家:\(self.bookmakerPoint)點"
                                            self.result()
                                        }
                                    }
                                }
                                else
                                {
                                    self.result()
                                }
                            }
                        }
                    }
                    else
                    {
                        self.result()
                    }
                    
                }
            }
        }
        else
        {
            result()
        }
    }
    
    func result()
    {
        bookmakerPointLabel.isHidden = false
            if playerPoint == 21
            {
                bookmakerCardView1.image = UIImage(named: "\(bookmakerCard1.suit)\(bookmakerCard1.rank)")
                bookmakerPointLabel.text = "莊家:\(bookmakerPoint)點"
                playerWinEffect()
                resultLabel.isHidden = false
                resultLabel.text = "Player Win"
                score = score + betScore * 2
                print("player = 21")
                scoreLabel.text = "目前積分:\(score)"
            }
            else if bookmakerPoint == 21
            {
                bookmakerCardView1.image = UIImage(named: "\(bookmakerCard1.suit)\(bookmakerCard1.rank)")
                bookmakerPointLabel.text = "莊家:\(bookmakerPoint)點"
                loseEffect()
                resultLabel.isHidden = false
                resultLabel.text = "Player lose"
                scoreLabel.text = "目前積分:\(score)"
            }
            else if playerPoint > 21
            {
                bookmakerCardView1.image = UIImage(named: "\(bookmakerCard1.suit)\(bookmakerCard1.rank)")
                bookmakerPointLabel.text = "莊家:\(bookmakerPoint)點"
                loseEffect()
                resultLabel.isHidden = false
                resultLabel.text = "Player lose"
                scoreLabel.text = "目前積分:\(score)"
            }
            else if playerPoint < 21 && bookmakerPoint < 21
            {
                if playerPoint > bookmakerPoint
                {
                    bookmakerCardView1.image = UIImage(named: "\(bookmakerCard1.suit)\(bookmakerCard1.rank)")
                    bookmakerPointLabel.text = "莊家:\(bookmakerPoint)點"
                    playerWinEffect()
                    resultLabel.isHidden = false
                    resultLabel.text = "Player Win"
                    score = score + betScore * 2
                    print("player win bookmaker")
                    scoreLabel.text = "目前積分:\(score)"
                }
                else if playerPoint < bookmakerPoint
                {
                    bookmakerCardView1.image = UIImage(named: "\(bookmakerCard1.suit)\(bookmakerCard1.rank)")
                    bookmakerPointLabel.text = "莊家:\(bookmakerPoint)點"
                    loseEffect()
                    resultLabel.isHidden = false
                    resultLabel.text = "Player lose"
                    scoreLabel.text = "目前積分:\(score)"
                }
                else if playerPoint == bookmakerPoint
                {
                    bookmakerCardView1.image = UIImage(named: "\(bookmakerCard1.suit)\(bookmakerCard1.rank)")
                    bookmakerPointLabel.text = "莊家:\(bookmakerPoint)點"
                    tieEffect()
                    resultLabel.isHidden = false
                    resultLabel.text = "平手"
                    score = score + betScore
                    scoreLabel.text = ("目前積分:\(score)")
                }
            }
            else if bookmakerPoint > 21
            {
                bookmakerCardView1.image = UIImage(named: "\(bookmakerCard1.suit)\(bookmakerCard1.rank)")
                bookmakerPointLabel.text = "莊家:\(bookmakerPoint)點"
                playerWinEffect()
                resultLabel.isHidden = false
                resultLabel.text = "Player Win"
                score = score + betScore * 2
                print("bookmaker lose")
                scoreLabel.text = "目前積分:\(score)"
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 6)
            {
                self.clearUI()
                self.playerPoint = 0
                self.bookmakerPoint = 0
                self.playerAddCardCount = 0
                self.bookmakerAddCardCount = 0
                self.raiseAndNoRaiseDisable()
                self.betScoreLabel.text = ""

                if self.score == 0
                {
                    self.playBtn.isHidden = false
                    self.playBtn.isEnabled = true
                    self.betBtnDisable()
                    self.wrongEffect()
                    self.resultLabel.isHidden = false
                    self.resultLabel.text = "您已無積分,請按PLAY開始"
                    self.playerPointLabel.text = ""
                    self.playerPointLabel.isHidden = true
                    self.bookmakerPointLabel.text = ""
                    self.bookmakerPointLabel.isHidden = true
                    
                }
                else
                {
                    self.resultLabel.isHidden = false
                    self.resultLabel.text = "請下注"
                    self.playerPointLabel.text = ""
                    self.playerPointLabel.isHidden = true
                    self.bookmakerPointLabel.text = ""
                    self.bookmakerPointLabel.isHidden = true
                    self.betBtnEnable()
                }
                
            }
    }
    func clearUI()
    {
        self.playerCardView1.image = nil
        self.playerCardView2.image = nil
        self.bookmakerCardView1.image = nil
        self.bookmakerCardView2.image = nil
        if self.playerCardView1.tag == 101
        {
            self.playerCardView1.removeFromSuperview()
        }
        self.playerCardView2.image = nil
        if self.playerCardView2.tag == 102
        {
            self.playerCardView2.removeFromSuperview()
        }
        self.bookmakerCardView1.image = nil
        self.bookmakerCardView2.image = nil
        self.bookmakerCardView1.image = nil
        self.playerCardView3.image = nil
        if self.playerCardView3.tag == 103
        {
            self.playerCardView3.removeFromSuperview()
        }
        self.playerCardView4.image = nil
        if self.playerCardView4.tag == 104
        {
            self.playerCardView4.removeFromSuperview()
        }
        self.playerCardView5.image = nil
        if self.playerCardView5.tag == 105
        {
            self.playerCardView5.removeFromSuperview()
        }
        self.bookmakerCardView1.image = nil
        if self.bookmakerCardView1.tag == 201
        {
            self.bookmakerCardView1.removeFromSuperview()
        }
        self.bookmakerCardView2.image = nil
        if self.bookmakerCardView2.tag == 202
        {
            self.bookmakerCardView2.removeFromSuperview()
        }
        self.bookmakerCardView3.image = nil
        if self.bookmakerCardView3.tag == 203
        {
            self.bookmakerCardView3.removeFromSuperview()
        }
        self.bookmakerCardView4.image = nil
        if self.bookmakerCardView4.tag == 204
        {
            self.bookmakerCardView4.removeFromSuperview()
        }
        self.bookmakerCardView5.image = nil
        if self.bookmakerCardView5.tag == 205
        {
            self.bookmakerCardView5.removeFromSuperview()
        }
       
       
       
    }
    
// MARK: - Card UI
    func playerCard1UI()
    {
        view.addSubview(playerCardView1)
        playerCardView1.translatesAutoresizingMaskIntoConstraints = false
        
        
        playerCardView1.image = UIImage(named: "pokerbaker")
        playerCard1ViewPositionX = playerCardView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        playerCard1ViewPositionX?.isActive = true
       
        playerCard1ViewPositionY = playerCardView1.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        playerCard1ViewPositionY?.isActive = true
   
        playerCardView1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playerCardView1.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        playerCardView1.tag = 101
    }
    
    func bookmakerCard1UI()
    {
        view.addSubview(bookmakerCardView1)
        bookmakerCardView1.translatesAutoresizingMaskIntoConstraints = false
        
        bookmakerCardView1.image = UIImage(named: "pokerbaker")
        bookmakerCard1ViewPositionX = bookmakerCardView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        bookmakerCard1ViewPositionX?.isActive = true
       
        bookmakerCard1ViewPositionY = bookmakerCardView1.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        bookmakerCard1ViewPositionY?.isActive = true
   
        bookmakerCardView1.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bookmakerCardView1.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        bookmakerCardView1.tag = 201
    }
    
    func playerCard2UI()
    {
        view.addSubview(playerCardView2)
        playerCardView2.translatesAutoresizingMaskIntoConstraints = false
        
        playerCardView2.image = UIImage(named: "pokerbaker")
        playerCard2ViewPositionX = playerCardView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        playerCard2ViewPositionX?.isActive = true
       
        playerCard2ViewPositionY = playerCardView2.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        playerCard2ViewPositionY?.isActive = true
   
        playerCardView2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playerCardView2.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        playerCardView2.tag = 102
    }
    
    func bookmakerCard2UI()
    {
        view.addSubview(bookmakerCardView2)
        bookmakerCardView2.translatesAutoresizingMaskIntoConstraints = false
        
        bookmakerCardView2.image = UIImage(named: "pokerbaker")
        bookmakerCard2ViewPositionX = bookmakerCardView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        bookmakerCard2ViewPositionX?.isActive = true
       
        bookmakerCard2ViewPositionY = bookmakerCardView2.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        bookmakerCard2ViewPositionY?.isActive = true
   
        bookmakerCardView2.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bookmakerCardView2.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        bookmakerCardView2.tag = 202
    }
    
    func playerCard3UI()
    {
        view.addSubview(playerCardView3)
        playerCardView3.translatesAutoresizingMaskIntoConstraints = false
        
        playerCardView3.image = UIImage(named: "pokerbaker")
        playerCard3ViewPositionX = playerCardView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        playerCard3ViewPositionX?.isActive = true
       
        playerCard3ViewPositionY = playerCardView3.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        playerCard3ViewPositionY?.isActive = true
   
        playerCardView3.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playerCardView3.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        playerCardView3.tag = 103
    }
    
    func playerCard4UI()
    {
        view.addSubview(playerCardView4)
        playerCardView4.translatesAutoresizingMaskIntoConstraints = false
        
        playerCardView4.image = UIImage(named: "pokerbaker")
        playerCard4ViewPositionX = playerCardView4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        playerCard4ViewPositionX?.isActive = true
       
        playerCard4ViewPositionY = playerCardView4.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        playerCard4ViewPositionY?.isActive = true
   
        playerCardView4.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playerCardView4.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        playerCardView4.tag = 104
    }
    
    func playerCard5UI()
    {
        view.addSubview(playerCardView5)
        playerCardView5.translatesAutoresizingMaskIntoConstraints = false
        
        playerCardView5.image = UIImage(named: "pokerbaker")
        playerCard5ViewPositionX = playerCardView5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        playerCard5ViewPositionX?.isActive = true
       
        playerCard5ViewPositionY = playerCardView5.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        playerCard5ViewPositionY?.isActive = true
   
        playerCardView5.widthAnchor.constraint(equalToConstant: 50).isActive = true
        playerCardView5.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        playerCardView5.tag = 105
    }

    func bookmakerCard3UI()
    {
        view.addSubview(bookmakerCardView3)
        bookmakerCardView3.translatesAutoresizingMaskIntoConstraints = false
        
        bookmakerCardView3.image = UIImage(named: "pokerbaker")
        bookmakerCard3ViewPositionX = bookmakerCardView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        bookmakerCard3ViewPositionX?.isActive = true
       
        bookmakerCard3ViewPositionY = bookmakerCardView3.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        bookmakerCard3ViewPositionY?.isActive = true
   
        bookmakerCardView3.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bookmakerCardView3.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        bookmakerCardView3.tag = 203
    }
    
    func bookmakerCard4UI()
    {
        view.addSubview(bookmakerCardView4)
        bookmakerCardView4.translatesAutoresizingMaskIntoConstraints = false
        
        bookmakerCardView4.image = UIImage(named: "pokerbaker")
        bookmakerCard4ViewPositionX = bookmakerCardView4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        bookmakerCard4ViewPositionX?.isActive = true
       
        bookmakerCard4ViewPositionY = bookmakerCardView4.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        bookmakerCard4ViewPositionY?.isActive = true
   
        bookmakerCardView4.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bookmakerCardView4.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        bookmakerCardView4.tag = 204
    }
    
    func bookmakerCard5UI()
    {
        view.addSubview(bookmakerCardView5)
        bookmakerCardView5.translatesAutoresizingMaskIntoConstraints = false
        
        bookmakerCardView5.image = UIImage(named: "pokerbaker")
        bookmakerCard5ViewPositionX = bookmakerCardView5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        bookmakerCard5ViewPositionX?.isActive = true
       
        bookmakerCard5ViewPositionY = bookmakerCardView5.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        bookmakerCard5ViewPositionY?.isActive = true
   
        bookmakerCardView5.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bookmakerCardView5.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        bookmakerCardView5.tag = 205
    }
    
    func cardBakerUI()
    {
        view.addSubview(cardBakerView)
        cardBakerView.translatesAutoresizingMaskIntoConstraints = false
        
        cardBakerView.image = UIImage(named: "pokerbaker")
        cardBakerViewPositionX = cardBakerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 650)
        cardBakerViewPositionX?.isActive = true
       
        cardBakerViewPositionY = cardBakerView.topAnchor.constraint(equalTo: view.topAnchor,constant: 70)
        cardBakerViewPositionY?.isActive = true
   
        cardBakerView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cardBakerView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        cardBakerView.tag = 300
        
    }
    // MARK: - SoundEffects
    func blackJackEffect()
    {
        let fileUrl = Bundle.main.url(forResource: "BlackJack", withExtension: "mp3")!
        let playItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playItem)
        player.play()
    }
    
    func playerWinEffect()
    {
        let fileUrl = Bundle.main.url(forResource: "playerwin", withExtension: "mp3")!
        let playItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playItem)
        player.play()
    }
    
    func loseEffect()
    {
        let fileUrl = Bundle.main.url(forResource: "lose", withExtension: "mp3")!
        let playItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playItem)
        player.play()
    }
    
    func wrongEffect()
    {
        let fileUrl = Bundle.main.url(forResource: "wrongbuzzer", withExtension: "mp3")!
        let playItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playItem)
        player.play()
    }
    
    func licensingEffect()
    {
        let fileUrl = Bundle.main.url(forResource: "licensing", withExtension: "mp3")!
        let playItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playItem)
        player.play()
    }
    
    func tieEffect()
    {
        let fileUrl = Bundle.main.url(forResource: "tie", withExtension: "mp3")!
        let playItem = AVPlayerItem(url: fileUrl)
        player.replaceCurrentItem(with: playItem)
        player.play()
    }
}
