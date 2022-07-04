//
//  ViewController.swift
//  LaunchPadGame
//
//  Created by GOngTAE on 2021/12/19.
//

import UIKit
import Lottie

final class MainViewController: UIViewController {
    
    private var buttonWorkItem: DispatchWorkItem?
    private var buttonEventTimer: Timer?
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBAction func modeChanged(_ sender: UISegmentedControl) {
        
    }
    
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var HpGageView: UIProgressView!
    @IBOutlet weak var feverFireView: UIView!
    @IBOutlet weak var feverImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var buttonCollectionView: UICollectionView!
    
    @IBOutlet weak var currentSongView: UIView!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    
    
    let player = AudioPlayer.shared
    var readiedButton = Array(repeating: false, count: 16)
    
    var count = 0 {
        didSet {
            scoreLabel.text = "score: \(count)"
        }
    }
    
    var isFever = false {
        didSet {
            if isFever {
                feverFireView.isHidden = false
                feverImageView.isHidden = false
            } else {
                feverFireView.isHidden = true
                feverImageView.isHidden = true
            }
        }
    }
    
    var isPlaying: Bool = false {
        didSet {
            if isPlaying {
                playButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            } else {
                playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }
    
    
    @IBOutlet weak var playButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        self.buttonCollectionView.delegate = self
        self.buttonCollectionView.dataSource = self
        
        buttonCollectionView.backgroundColor = .clear
        
        player.setCurrentItem(songName: "ily")
        
        
        //뷰 모양 수정
        albumImageView.layer.cornerRadius = albumImageView.frame.height / 2
        albumImageView.clipsToBounds = true
        
        currentSongView.layer.masksToBounds = true
        currentSongView.layer.cornerRadius = 10
        currentSongView.backgroundColor = UIColor(white: 1, alpha: 0.7)
        
        logoImageView.layer.masksToBounds = true
        logoImageView.layer.cornerRadius = 10
        logoImageView.backgroundColor = UIColor(white: 1, alpha: 0.7)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.albumImageView.image = UIImage(named: self.player.currentItem?.name ?? "ily")
            self.titleLabel.text = self.player.currentItem?.name
            self.singerLabel.text = self.player.currentItem?.singer
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //뷰전환시 모든 작업중지 및 뷰 초기화
        stopButtonEvent()
        player.pause()
        count = 0
        HpGageView.progress = 0
        isFever = false
    }
    
  private  func stopButtonEvent() {
        
        //버튼 이벤트 내부 타이머 동작 중지
        if let buttonEventTimer = buttonEventTimer {
            if buttonEventTimer.isValid {
                buttonEventTimer.invalidate()
                print("timer isValid : \(buttonEventTimer.isValid)")
            }
        }
        
        //버튼 이벤트 디스패치 큐에서 제거
        if let buttonWorkItem = buttonWorkItem {
            buttonWorkItem.cancel()
            print("buttonWorkItem : \(buttonWorkItem.isCancelled)")
        }
    }
    
    
    
    
   
    @IBAction func playButtonTapped(_ sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: CGFloat(0.40), initialSpringVelocity: CGFloat(4.0), options: UIView.AnimationOptions.allowUserInteraction) {
            sender.transform = CGAffineTransform.identity
        } completion: { Void in()
            
        }
        
        if isPlaying {
            albumImageView.layer.removeAllAnimations()
            self.player.pause()
            self.stopButtonEvent()
            self.isPlaying = false
            if self.isFever {
                self.isFever = false
            }
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.player.setCurrentItem(songName: self.player.currentItem?.name ?? "ily")
            }
        } else {
            
            player.pause()
            
            player.playCurrentSong()
            isPlaying = true
            let readyTransform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            
            DispatchQueue.main.async {
                
                //미완성 코드 [ ] 하트 콩닥거리는 애니메이션 작성중
                Timer.scheduledTimer(withTimeInterval: 1.12, repeats: true) { timer in
                    
                    self.heartImageView.transform = readyTransform
                }
            }
            
            DispatchQueue.main.async {
                self.albumImageView.transform = readyTransform
                
                UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: CGFloat(0.40), initialSpringVelocity: CGFloat(4.0), options: UIView.AnimationOptions.allowUserInteraction) {
                    self.albumImageView.transform = CGAffineTransform.identity
                } completion: { Void in()
                    
                }
                self.albumImageView.rotate()
            }
            
            buttonWorkItem = DispatchWorkItem {
                let secPerBeat = 60 / Double(self.player.currentItem?.bpm ?? 110)
                
                self.buttonEventTimer = Timer.scheduledTimer(withTimeInterval: secPerBeat, repeats: true) { timer in
                        //난수 발생
                    let randomIndex = Int.random(in: 0...15)

                    //난수에 해당하는 버튼 크기 증가
                    UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: [.curveEaseOut]) {
                        self.buttonCollectionView.visibleCells[randomIndex].transform = readyTransform
                    } completion: { done in
                        if done {
                            
                            //크기 증가 완료 시에 준비된 버튼 인덱스 값을 true 로 만듦
                            self.readiedButton[MainViewModel.mapIndex(before: randomIndex)] = true
                            print("button readied!! \(randomIndex)")
                        }
                    }
                }
            }
            
            let start = player.currentItem?.start ?? 16
            if let buttonWorkItem = buttonWorkItem {
                DispatchQueue.main.asyncAfter(deadline: .now() + start, execute: buttonWorkItem)
            }
        }
    }
}

// 앨범이미지 뷰 회전을 위한 애니메이션 View 확장
extension UIView{
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 2
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
        //준비된 버튼 터치시 점수 증가
        
        if player.player.isPlaying {
            if readiedButton[indexPath.row] {
                readiedButton[indexPath.row] = false
                
                
                // 피버 타임에 따른 점수 등락 폭 조정
                if isFever {
                    count = count + 100
                } else {
                    count = count + 10
                }
                
                if HpGageView.progress == 1, !isFever {
                    // Fever Event!
                    
                    
                    let animationView = AnimationView(name: "fever")
                    
                    feverFireView.addSubview(animationView)
                    feverFireView.bringSubviewToFront(self.feverImageView)
                    animationView.frame = animationView.superview!.bounds
                    animationView.contentMode = .scaleToFill
                    animationView.play()
                    animationView.loopMode = .loop
                    isFever = true
                    
                }
                HpGageView.progress = HpGageView.progress + 0.05
            } else {
                count = count - 10
                HpGageView.progress = HpGageView.progress - 0.05
                
                if isFever {
                    isFever = false
                }
            }
        }
    
        //터치시 스프링 애니메이션
        if let cell = collectionView.cellForItem(at: indexPath) as? ButtonCollectionViewCell {
            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: CGFloat(0.40), initialSpringVelocity: CGFloat(4.0), options: UIView.AnimationOptions.allowUserInteraction) {
                cell.transform = CGAffineTransform.identity
            } completion: { Void in()
                
            }

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
 
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    //위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    //옆간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    //cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4 - 6
        let size = CGSize(width: width, height: width)
        
        return size
    }
}
