//
//  MenuTableViewCell.swift
//  RadioTest
//
//  Created by Alejandro Arce on 23/11/22.
//

import Foundation
import UIKit

protocol MenuTableViewCellDelegate {
    func tapGenreCell(cell: MenuTableViewCell)
}

class MenuTableViewCell : UITableViewCell {
    var delegate : MenuTableViewCellDelegate?
    
    lazy var genreButton : UIButton = {
        let genreButton = UIButton(frame: CGRect(x: 20, y: 10, width: 100, height: 30))
        genreButton.setTitleColor(UIColor.green, for: .normal)
        genreButton.contentHorizontalAlignment = .left
        genreButton.setTitleColor(UIColor.white, for: .highlighted)
        genreButton.addTarget(self, action: #selector(tapGenreCell), for: .touchUpInside)
        return genreButton
    }()
    @objc func tapGenreCell() {
        delegate?.tapGenreCell(cell: self)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(genreButton)
    }
    func configureLabel(label: String) {
        genreButton.setTitle(" • \(label)", for: .normal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
