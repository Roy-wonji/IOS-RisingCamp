//
//  MusicViewController.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/10.
//

import Foundation

import UIKit
import Then
import SnapKit
import RxSwift

final class MusicViewController: UIViewController {
    
    //MARK: - Prpoperties
    private let tableView = UITableView()
    private var navigatioion = UINavigationBar()
    private var disposeBag = DisposeBag()
    private var musicArrays: [Music] = []
    private var networkManager = MusicNetworkManger.shared
//    private let searchController = UISearchController()
    var timer: Timer?
    //MARK: - Lifecycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUI()
        setupAPI()
        view.backgroundColor = .white
        
    }
    
    //MARK:  - UI
    private func configureUI() {
        Observable.just(MainViewController())
            .subscribe(
                onNext : { _ in
                    self.setNavigationBar()
//                    self.setupSearchController()
                    self.updateVeiw()
                    self.updateViewConstraints()
                    self.setTableView()
                })
            .disposed(by: disposeBag)
    }
    
    
    
    private func setNavigationBar() {
        navigationItem.title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
//        navigationItem.searchController = searchController
        
        
    }
    
//    private func setupSearchController() {
//        searchController.searchBar.placeholder = "Search"
//        searchController.searchResultsUpdater = self
//        //        searchController.searchBar.autocapitalizationType = .none
//        searchController.obscuresBackgroundDuringPresentation = false
//    }
    
    //MARK: - API
    
    private func setupAPI() {
        networkManager.fetchMusic(searchTerm: "kpop") { result in
            switch result{
            case .success(let musicDatas):
                // 데이터(배열)을 받아오고 난 후
                self.musicArrays = musicDatas
                // 테이블뷰 리로드
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func updateVeiw() {
        view.addSubview(tableView)
    }
    
    
    private func setTableView() {
        Observable<UITableView>.just(tableView)
            .subscribe(
                onNext: { _ in
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.register(MusicCell.self, forCellReuseIdentifier: Celldentifier.mainViewTableIdentifier)
                })
            .disposed(by: disposeBag)
        
    }
    
    
    override func updateViewConstraints() {
        setConstraints()
        super.updateViewConstraints()
    }
    
    private func setConstraints() {
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
        }
    }
}

extension MusicViewController: UITableViewDelegate {
    
    
}


extension MusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Celldentifier.mainViewTableIdentifier, for: indexPath) as! MusicCell
       cell.imageUrl = musicArrays[indexPath.row].imageUrl
        cell.songNameLabel.text = musicArrays[indexPath.row].songName
        cell.artistName.text = musicArrays[indexPath.row].artistName
        cell.albumName.text = musicArrays[indexPath.row].albumName
        cell.releaseDate.text = musicArrays[indexPath.row].releaseDateString
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension MusicViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let text = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        if searchText != "" {
            timer?.invalidate()
            
        }
    }
}


extension MusicViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        print( "서치바에 입력되는 단어",searchController.searchBar.text ?? Common.wronInput)
//        let search = searchController.searchResultsController as? SearchController
        //      search.searchTerm = searchController.searchBar.text ?? ""
    }
    
}
