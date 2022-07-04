//
//  .swift
//  LaunchPadGame
//
//  Created by 서원지 on 2022/06/29.
//

import Foundation
import AVFoundation



class AudioPlayer {
    
    //싱글톤 패턴 사용
    static let shared = AudioPlayer()
    
    var player =  AVAudioPlayer()
    var currentItem: Song?
    let songList: [Song] = [Song(name: "ily", singer: "Surf Mesa", bpm: 110, start: 17),
                            Song(name: "ChristMas HipHop", singer: "Unknown", bpm: 99, start: 12),
                            Song(name: "Last ChristMas", singer: "Ariana Grande", bpm: 99, start: 16.3),
                            Song(name: "Save Your Tears", singer: "The Weeknd", bpm: 119, start: 7.4)]
    
    
    
    //현재 노래 변경
    func setCurrentItem(songName: String) {
        
        for song in self.songList {
            if song.name == songName {
                self.currentItem = song
                
                guard let name = self.currentItem?.name else {return}
                
                print(name)
                let url = Bundle.main.url(forResource: name, withExtension: "mp3")
                
                if let url = url {
                    do {
                        self.player = try AVAudioPlayer(contentsOf: url)
                        self.player.prepareToPlay()
                        print("complete")


                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
    }
    
    //현재 항목 재생
    func playCurrentSong() {
        //현재 노래 항목 불러오기
        player.play()
    }
    
    //재생 일시정지
    func pause() {
        if player.isPlaying {
            player.pause()
        }
    }
}
