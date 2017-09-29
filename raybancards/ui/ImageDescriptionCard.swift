//
//  ImageDescriptionCard.swift
//  raybancards
//
//  Created by Luis Ezcurdia on 9/27/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit
import SnapKit

class ImageDescriptionCard: UICollectionViewCell {
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "white-closed")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let lblTitle : UILabel = {
        let lbl = UILabel()
        lbl.text = "title"
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        return lbl
    }()
    
    let lblContent : UITextView = {
        let lbl = UITextView()
        lbl.text = "lorem ipsum dolor quet"
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 18)
        lbl.isEditable = false
        lbl.isScrollEnabled = false
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    var image : UIImage? {
        didSet { self.imageView.image = self.image }
    }
    var title : String? {
        didSet { self.lblTitle.text = self.title }
    }
    var content : String? {
        didSet { self.lblContent.text = self.content }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    func setupSubviews() {
        addSubview(self.imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(150)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.height.equalTo(170)
        }
        addSubview(lblTitle)
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.height.equalTo(25)
        }
        addSubview(lblContent)
        lblContent.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(15)
            make.left.equalTo(snp.left).offset(10)
            make.right.equalTo(snp.right).offset(-10)
            make.height.equalTo(snp.height).dividedBy(4)
        }
        
    }

}
