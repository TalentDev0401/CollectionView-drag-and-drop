//
//  ViewController.swift
//  DragAndDrop
//
//  Created by Kirill Chistyakov on 29.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {
    
    var items: [Any] = Item.getArray()
    
    let collectionView: UICollectionView = {
        let flowLayout = CustomFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.stackedDelegate = self
        collectionView.stackedDataSource = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        topLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: collectionView.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: collectionView.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }

}

// MARK: UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        if let item = items[indexPath.item] as? Item {
            cell.items = [item]
        } else if let items = items[indexPath.item] as? [Item] {
            cell.items = items
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = items[sourceIndexPath.item]
        items.remove(at: sourceIndexPath.item)
        items.insert(item, at: destinationIndexPath.item)
    }
    
}

// MARK: StackedCollectionViewDelegate

extension ViewController: StackedCollectionViewDelegate {
    
    func collectionViewGestureDidMoveOutsideTriggerRadius(_ collectionView: UICollectionView) {
        print("Gesture moved outside trigger radius")
    }
    
    func collectionView(_ collectionView: UICollectionView, animationControllerFor indexPath: IndexPath) -> UICollectionViewCellAnimatedTransitioning? {
        return CustomTransitionAnimator()
    }
    
}

// MARK: StackedCollectionViewDataSource

extension ViewController: StackedCollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt sourceIndexPath: IndexPath, into stackDestinationIndexPath: IndexPath) -> Bool {
        if
            items[sourceIndexPath.item] is [Item], // Block moving a stack...
            items[stackDestinationIndexPath.item] is Item // ...onto an item.
        {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, into stackDestinationIndexPath: IndexPath) {
        
        print("Add item at index \(sourceIndexPath.item) into index \(stackDestinationIndexPath.item).")
        
        if let sourceItem = items[sourceIndexPath.item] as? Item {
            
            if let destinationItem = items[stackDestinationIndexPath.item] as? Item {
                
                items[stackDestinationIndexPath.item] = [sourceItem, destinationItem]
                items.remove(at: sourceIndexPath.item)
                
            } else if let destinationStack = items[stackDestinationIndexPath.item] as? [Item] {
                
                items[stackDestinationIndexPath.item] = destinationStack + [sourceItem]
                items.remove(at: sourceIndexPath.item)
                
            }
            
        } else if let sourceStack = items[sourceIndexPath.item] as? [Item] {
            
            if let destinationItem = items[stackDestinationIndexPath.item] as? Item {
                
                items[stackDestinationIndexPath.item] = sourceStack + [destinationItem]
                items.remove(at: sourceIndexPath.item)
                
            } else if let destinationStack = items[stackDestinationIndexPath.item] as? [Item] {
                
                items[stackDestinationIndexPath.item] = sourceStack + destinationStack
                items.remove(at: sourceIndexPath.item)
                
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, finishMovingItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("Move item from index \(sourceIndexPath.item) to index \(destinationIndexPath.item).")
    }
    
}

