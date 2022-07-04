//
//  SongTableViewController.swift
//  LaunchPadGame
//
//  Created by GOngTAE on 2021/12/19.
//

import UIKit

final class SongTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let player = AudioPlayer.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let  header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
        
        let headerLabel = UILabel(frame: header.bounds)
        
        headerLabel.text = "Track list"
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 30)
        header.addSubview(headerLabel)
        
        tableView.tableHeaderView = header
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.pause()
        
        // 플레이어 재생시점 맨앞으로 초기화
        DispatchQueue.global(qos: .userInitiated).async {
            self.player.setCurrentItem(songName: self.player.currentItem?.name ?? "ily")
        }
        
    }
}



extension SongTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell
        
        let item = player.songList[indexPath.row]
        
        cell.albumImageView.image = UIImage(named: item.name)
        cell.titleLabel.text = item.name
        cell.singerLabel.text = item.singer
        cell.bpmLabel.text = "bpm : \(item.bpm)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player.pause()
        let selectedItem = player.songList[indexPath.row]
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.player.setCurrentItem(songName: selectedItem.name)
            self.player.playCurrentSong()
        }
        

    }
}
