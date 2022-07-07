//
//  MangoBar.swift
//  MangoPlateCloneApp
//
//  Created by 서원지 on 2022/07/07.
//

import Tabman

class MangoBar {
    
    typealias BarType = TMBarView<TMConstrainedHorizontalBarLayout, TMTabItemBarButton, MangoBarIndicator>
    
    static func makeBar() -> TMBar {
        let bar  = BarType()
        
        bar.scrollMode = .swipe
        bar .buttons.customize { button in
            button.tintColor = .gray
            button.selectedTintColor = TinderColors.barTintColor
        }
        
        bar.backgroundView.style = .flat(color: .white)
        bar.backgroundColor = .white
        bar.layout.transitionStyle = .snap
        return bar
    }
    
}

