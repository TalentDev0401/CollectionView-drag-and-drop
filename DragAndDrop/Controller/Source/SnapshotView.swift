//
//  SnapshotView.swift
//
//  Created by Kirill Chistyakov on 29.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

public class SnapshotView: UIView {
    
    struct ViewContainer {
        var view = UIView()
        var size = CGSize.zero
        var widthConstraint: NSLayoutConstraint!
        var heightConstraint: NSLayoutConstraint!
    }
    
    var state: UICollectionViewCellState = .unknown
    
    var normalViewContainer: ViewContainer?
    var dragViewContainer: ViewContainer?
    var stackViewContainer: ViewContainer?
    
    var allViewContainers: [ViewContainer?] {
        return [normalViewContainer, dragViewContainer, stackViewContainer]
    }
    
    func set(normalView: UIView) {
        normalViewContainer?.view.removeFromSuperview()
        normalViewContainer = nil
        normalViewContainer = add(view: normalView)
    }
    
    func set(dragView: UIView) {
        dragViewContainer?.view.removeFromSuperview()
        dragViewContainer = nil
        dragViewContainer = add(view: dragView)
        
    }
    
    func set(stackView: UIView) {
        stackViewContainer?.view.removeFromSuperview()
        stackViewContainer = nil
        stackViewContainer = add(view: stackView)
    }
    
    func add(view: UIView) -> ViewContainer {
        let size = view.bounds.size
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        let widthConstraint = view.widthAnchor.constraint(equalToConstant: view.bounds.width)
        widthConstraint.isActive = true
        let heightConstraint = view.heightAnchor.constraint(equalToConstant: view.bounds.height)
        heightConstraint.isActive = true
        return ViewContainer(view: view, size: size, widthConstraint: widthConstraint, heightConstraint: heightConstraint)
    }
    
    func showNormal() {
        guard let normalViewContainer = self.normalViewContainer else { return }
        show(showViewContainer: normalViewContainer)
        state = .normal
    }
    
    func showDrag() {
        guard let dragViewContainer = self.dragViewContainer else { return }
        show(showViewContainer: dragViewContainer)
        state = .drag
    }
    
    func showStack() {
        guard let stackViewContainer = self.stackViewContainer else { return }
        show(showViewContainer: stackViewContainer)
        state = .stackDrag
    }
    
    func showVanished() {
        for viewContainer in allViewContainers {
            viewContainer?.widthConstraint.constant = 0.0
            viewContainer?.heightConstraint.constant = 0.0
        }
        layoutIfNeeded()
    }
    
    func show(showViewContainer: ViewContainer) {
        for viewContainer in allViewContainers {
            viewContainer?.view.alpha = viewContainer?.view == showViewContainer.view ? 1.0 : 0.0
            viewContainer?.widthConstraint.constant = showViewContainer.size.width
            viewContainer?.heightConstraint.constant = showViewContainer.size.height
        }
        layoutIfNeeded()
    }
}
