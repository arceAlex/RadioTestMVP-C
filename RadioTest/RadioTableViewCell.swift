//
//  RadioTableViewCell.swift
//  RadioTest
//
//  Created by Alejandro Arce on 31/10/22.
//

import Foundation
import UIKit

protocol RadioTableViewDelegate {
    func touchPlayButton (cell: RadioTableViewCell)
    func tapFavouriteButton(cell: RadioTableViewCell)
}

class RadioTableViewCell : UITableViewCell {
    var delegate : RadioTableViewDelegate?
    var id : Int?
    var favouriteSelected : Bool?
    var station : RadioModel?
    let tint : UIColor = .white
    
    lazy var favouriteButton : UIButton = {
        let favouriteButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 5, width: 35, height: 35))
        favouriteButton.setImage(UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 15))), for: .normal)
        favouriteButton.setImage(UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 19))), for: .selected)
        favouriteButton.addTarget(self, action: #selector(tapFavouriteButton), for: .touchUpInside)
        return favouriteButton
    }()
    lazy var stationLabel : UILabel = {
        let label = UILabel(frame: CGRect(x: 80, y: 7.5, width: UIScreen.main.bounds.width - 125, height: 30))
        label.textColor = tint
        label.font = label.font.withSize(15)
        return label
    }()
    lazy var stationImage : UIImageView = {
        let stationImage = UIImageView(frame: CGRect(x: 20, y: 2.5, width: 40, height: 40))
        return stationImage
    }()
    lazy var gifSpeaker : UIImageView = {
        let gifSpeaker = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 70, y: 12.5, width: 20, height: 20))
        return gifSpeaker
    }()
    lazy var playButton : UIButton = {
        let playButton = UIButton(frame: CGRect(x: 0, y: 5, width: UIScreen.main.bounds.width - 80, height: 35))
        playButton.addTarget(self, action: #selector(touchPlayButton), for: .touchUpInside)
        return playButton
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(stationImage)
        self.contentView.addSubview(stationLabel)
        self.contentView.addSubview(favouriteButton)
        //self.contentView.addSubview(gifSpeaker)
        self.contentView.addSubview(playButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func touchPlayButton() {
        delegate?.touchPlayButton(cell: self)
    }
    @objc func tapFavouriteButton() {
        delegate?.tapFavouriteButton(cell: self)
    }
    func configureOnlyLabel (radio: RadioModel) {
        stationLabel.text = radio.station
    }
}
