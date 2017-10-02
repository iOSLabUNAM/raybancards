//
//  ImageDescriptionCard.swift
//  raybancards
//
//  Created by Luis Ezcurdia on 9/27/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import UIKit

class ImageDescriptionCard: UICollectionViewCell {
    let topContainer : UIView = {
        let view = UIView()
        return view
    }()
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(named: "white-closed")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let textView : UITextView = {
        let lbl = UITextView()
        lbl.isEditable = false
        lbl.isScrollEnabled = false
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    var image : UIImage? {
        didSet { self.imageView.image = self.image }
    }
    var title : String? {
        didSet { updateTextView() }
    }
    var content : String? {
        didSet { updateTextView() }
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
        addSubview(topContainer)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        topContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true

        topContainer.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: topContainer.heightAnchor, multiplier: 0.75).isActive = true

        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: topContainer.bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
    }

    func updateTextView() {
        let attributedText = NSMutableAttributedString(string: (title ?? ""), attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 24)])
        attributedText.append(NSAttributedString(string: "\n\n\n\(content ?? "")", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)]))
        textView.attributedText = attributedText
        textView.textAlignment = .center
    }
}
