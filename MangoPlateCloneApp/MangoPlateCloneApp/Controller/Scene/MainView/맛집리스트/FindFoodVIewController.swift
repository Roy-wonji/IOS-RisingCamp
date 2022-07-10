//
//  FindFoodVIewController.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/07.
//

import UIKit
import SnapKit
import Then
import RxSwift
import CoreLocation
import Kingfisher
import KakaoSDKUser
import FirebaseAuth
import GoogleSignIn
import Firebase

final class FindFoodVIewController:  UIViewController {
    
    
    //MARK: - Properties
    private let findFoodView = FindFoodView()
    override func loadView() {
        view = findFoodView
    }
    
    
    private let dispoeBag = DisposeBag()
    private var locationManager = CLLocationManager()
    private let kakaoLocalDataManager = KakaoLocalDataManager()
    private var musicArrays: [Music] = []
    private var networkManager = MusicNetworkManger.shared
    private var viewModel: FoodVIewModel?
    var refreashControl = UIRefreshControl()
    var restInfos: [RestInfo] = []
    var isAvailable = true
    
    
    private var currentLocationString: String = "강남구"
    private var x = "127.027610"
    private  var y = "37.498095"
    var page = 1
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupAPI()
    }
    
    //MARK:  - UI
    private func configureUI() {
        Observable.just(FindFoodVIewController())
            .subscribe(
                onNext: { [self] _ in
                    setCollectionView()
                    addTarget()
                    kakaoLocalDataManager.fetchRestaurants(x: x, y: y, page: 1, delegate: self)
                })
            .disposed(by: dispoeBag)
    }
    
    private func setCollectionView() {
        findFoodView.collection.register(FindFoodCollectionViewCell.self, forCellWithReuseIdentifier: Celldentifier.findFoodCollectionViewIdentifier)
        findFoodView.collection.isScrollEnabled = true
        
        //        findFoodView.collection.backgroundColor = .lightGray
        findFoodView.collection.delegate = self
        findFoodView.collection.dataSource = self
        findFoodView.collection.reloadData()
        findFoodView.collection.refreshControl = refreashControl
        refreashControl.addTarget(self, action: #selector(pullToRefreash), for: .valueChanged)
    }
    
    private func addTarget() {
        findFoodView.locationButton.rx.tap.subscribe(onNext: { self.loacationBottomSheet()}
        )
        .disposed(by: dispoeBag)
        findFoodView.mapBarButton.rx.tap.subscribe(onNext: { self.mapButtonHandle()}
        )
        .disposed(by: dispoeBag)
        findFoodView.searchBarButton.rx.tap.subscribe(onNext: { self.logOutButtonHandle()
            
        })
        .disposed(by: dispoeBag)
    }
    
    //MARK: - Actions
    
    @objc func loacationBottomSheet() {
        let bottomSheetViewController = LocationBottomSheet()
        let nav = UINavigationController(rootViewController: bottomSheetViewController)
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(nav, animated: true)
    }
    
    @objc func mapButtonHandle() {
        let mapViewController = FindFoodMapVIewController()
        
        self.present(mapViewController, animated: true)
    }
    
    @objc func logOutButtonHandle() {
        let loginView = LoginViewController()
        loginView.modalPresentationStyle = .fullScreen
        self.present(loginView, animated: true)
        logOutKakao()
        logOutGoogle()
    }
    
    private func logOutKakao() {
        UserApi.shared.rx.logout()
            .subscribe(onCompleted:{
                print("logout() success.")
                let loginView = LoginViewController()
                loginView.modalPresentationStyle = .fullScreen
                self.present(loginView, animated: true)
            }, onError: {error in
                print(error)
            })
            .disposed(by: dispoeBag)
    }
    
    private func logOutGoogle() {
        Single.just(FirebaseApp.self)
            .subscribe(
                {_ in
                    let firebseAuth = Auth.auth()
                    do {
                        try firebseAuth.signOut()
                        let loginView = LoginViewController()
                        loginView.modalPresentationStyle = .fullScreen
                        self.present(loginView, animated: true)
                    } catch let signoutError as NSError {
                        print("Error sigining pit ", signoutError)
                    }
                }
                
            )
            .disposed(by: dispoeBag)
    }
    @objc func pullToRefreash() {
        self.restInfos = []
        locationManager.requestLocation()
        kakaoLocalDataManager.fetchCurrentLocation(x: x, y: y) { locationString in
            
            self.currentLocationString = locationString
            self.findFoodView.locationButton.titleLabel?.text = self.currentLocationString
        }
        kakaoLocalDataManager.fetchRestaurants(x: x, y: y, page: 1, delegate: self)
        self.page = 1
        self.isAvailable = true    }
    
    
    //MARK:  - API
    
    private func setupAPI() {
        networkManager.fetchMusic(searchTerm: "kpop") { result in
            switch result{
            case .success(let musicDatas):
                // 데이터(배열)을 받아오고 난 후
                self.musicArrays = musicDatas
                // 테이블뷰 리로드
                DispatchQueue.main.async {
                    self.findFoodView.collection.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension FindFoodVIewController: UICollectionViewDelegate {
    
}


extension FindFoodVIewController: UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(restInfos.count)
        return musicArrays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: Celldentifier.findFoodCollectionViewIdentifier, for: indexPath) as! FindFoodCollectionViewCell
        cell.imageUrl = musicArrays[indexPath.item].imageUrl
        cell.titlelabels.text = musicArrays[indexPath.item].songName
        cell.distanceLabel.text = musicArrays[indexPath.item].albumName
        cell.viewCountLabel.text = musicArrays[indexPath.row].artistName
        cell.reviewCountLabel.text = musicArrays[indexPath.row].releaseDateString
        //        cell.titlelabels.text = restInfos[indexPath.row].detail.place_name
        return cell
    }
}
extension FindFoodVIewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width / 2) - 20
        return CGSize(width: width, height: 300)
    }
}

extension FindFoodVIewController {
    func failedToRequest(message: String) {
        Single.just(FindFoodVIewController())
            .subscribe(
                onSuccess: { _ in
                    self.dismissIndicator()
                    self.presentAlert(title: message)
                    self.isAvailable = true
                },
                onFailure: { error in
                    print(error.localizedDescription)
                })
            .disposed(by: dispoeBag)
    }
}

extension FindFoodVIewController {
    func didRetrieveLocal(response: KakaoLocalResponse) {
        
        
        DispatchQueue.main.async {
            self.findFoodView.collection.refreshControl?.endRefreshing()
        }
        
        if response.meta.is_end {
            self.isAvailable = false
        } else {
            self.isAvailable = true
        }
        print("🏄🏻‍♂️🏄🏻‍♂️\(response.documents)")
    }
    
}



extension FindFoodVIewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            
            self.x = String(coordinate.longitude)
            self.y = String(coordinate.latitude)
            print("🗺 🗺 🗺위치 정보 불러오기 완료")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription + "🗺 🗺 🗺🗺 🗺 🗺 ")
    }
}

