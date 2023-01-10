//
//  LoadingView.swift
//  RadioTest
//
//  Created by Alejandro Arce on 11/12/22.
//

import Foundation
import UIKit

class LoadingView : UIView {
    var transparentScreen : UIView = {
        let transparentScreen = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        transparentScreen.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        return transparentScreen
    }()
    var loadingGif : UIImageView = {
        let loadingGif = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width/2) - 50, y: (UIScreen.main.bounds.height/2) - 50 , width: 100, height: 100))
        //radioView.gifAudio.image = UIImage.gifImageWithName("AudioGif")
        loadingGif.image = UIImage.gifImageWithName("LoadingScreenGif")
        return loadingGif
    }()
    init() {
        super.init(frame: UIScreen.main.bounds)
        addSubview(transparentScreen)
        addSubview(loadingGif)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
