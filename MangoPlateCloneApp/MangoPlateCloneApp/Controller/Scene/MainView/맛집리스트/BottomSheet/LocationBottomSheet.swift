//
//  LocationBottomSheet.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/11.
//

import UIKit
import RxSwift

final class LocationBottomSheet: UIViewController {
    
    private let bottomSheetView = LocationBottomSheetView()
    private var disposeBag = DisposeBag()
    
    override func loadView() {
        view = bottomSheetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bottomSheetView.button.resignFirstResponder()
    }
}
