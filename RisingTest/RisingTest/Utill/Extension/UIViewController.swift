//
//  UIViewController.swift
//  RisingTest
//
//  Created by 서원지 on 2022/07/12.
//

import UIKit

extension UIViewController {
    // MARK: 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    // MARK: 취소와 확인이 뜨는 UIAlertController
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      handler: ((UIAlertAction) -> Void)? = nil) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionDone = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(actionDone)
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: 커스텀 UIAction이 뜨는 UIAlertController
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      with actions: UIAlertAction ...) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UIWindow의 rootViewController를 변경하여 화면전환
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    // MARK: 커스텀 하단 경고창
    func presentBottomAlert(message: String, target: NSLayoutYAxisAnchor? = nil, offset: Double? = -12) {
        view.subviews
            .filter { $0.tag == 936419836287461 }
            .forEach { $0.removeFromSuperview() }
        
        let alertSuperview = UIView()
        alertSuperview.tag = 936419836287461
        alertSuperview.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        alertSuperview.layer.cornerRadius = 10
        alertSuperview.isHidden = true
        alertSuperview.translatesAutoresizingMaskIntoConstraints = false
    
        let alertLabel = UILabel()
        alertLabel.font = UIFont.systemFont(ofSize: 15)
        alertLabel.textColor = .white
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(alertSuperview)
        alertSuperview.bottomAnchor.constraint(equalTo: target ?? view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        alertSuperview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertSuperview.addSubview(alertLabel)
        alertLabel.topAnchor.constraint(equalTo: alertSuperview.topAnchor, constant: 6).isActive = true
        alertLabel.bottomAnchor.constraint(equalTo: alertSuperview.bottomAnchor, constant: -6).isActive = true
        alertLabel.leadingAnchor.constraint(equalTo: alertSuperview.leadingAnchor, constant: 12).isActive = true
        alertLabel.trailingAnchor.constraint(equalTo: alertSuperview.trailingAnchor, constant: -12).isActive = true
        
        alertLabel.text = message
        alertSuperview.alpha = 1.0
        alertSuperview.isHidden = false
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            options: .curveEaseIn,
            animations: { alertSuperview.alpha = 0 },
            completion: { _ in
                alertSuperview.removeFromSuperview()
            }
        )
    }
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
}
