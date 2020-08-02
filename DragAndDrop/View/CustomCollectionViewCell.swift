//
//  CustomCollectionViewCell.swift
//
//  Created by Kirill Chistyakov on 29.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    var items: [Item]? {
        didSet {
            if let items = items {
                thumbnailView.images = items.map { $0.image! }
                nameLabel.text = items.count == 1 ? items[0].name : "\(items.count) items"
            } else {
                thumbnailView.images = nil
                nameLabel.text = nil
            }
        }
    }
    
    let thumbnailView = ThumbnailView()
    
    let stackIndicatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6.0
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        return label
    }()
    
    var stackIndicatorWidthConstraint: NSLayoutConstraint!
    var stackIndicatorHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        items = nil
    }
    
    private func initialize() {
        
        addSubview(thumbnailView)
        topAnchor.constraint(equalTo: thumbnailView.topAnchor).isActive = true
        leftAnchor.constraint(equalTo: thumbnailView.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: thumbnailView.rightAnchor).isActive = true
        thumbnailView.widthAnchor.constraint(equalTo: thumbnailView.heightAnchor).isActive = true
        
        insertSubview(stackIndicatorView, belowSubview: thumbnailView)
        thumbnailView.centerXAnchor.constraint(equalTo: stackIndicatorView.centerXAnchor).isActive = true
        thumbnailView.centerYAnchor.constraint(equalTo: stackIndicatorView.centerYAnchor).isActive = true
        stackIndicatorWidthConstraint = thumbnailView.widthAnchor.constraint(equalTo: stackIndicatorView.widthAnchor)
        stackIndicatorWidthConstraint.isActive = true
        stackIndicatorHeightConstraint = thumbnailView.heightAnchor.constraint(equalTo: stackIndicatorView.heightAnchor)
        stackIndicatorHeightConstraint.isActive = true
        
        addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: thumbnailView.bottomAnchor, constant: 8.0).isActive = true
        leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
    }
    
}

