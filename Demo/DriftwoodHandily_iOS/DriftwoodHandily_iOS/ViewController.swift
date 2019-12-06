//
//  ViewController.swift
//  DriftwoodHandily
//

import UIKit
import DriftwoodHandily

class ViewController: UIViewController {
    
    private weak var vTop: UIView!
    private weak var vBottom: UIView!
    private weak var vCenter: UIView!
    private weak var vLeading: UIView!
    private weak var vTrailing: UIView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vTop = self.view.createSubView()
        self.vTop.make(labeled: "Top").bottom(0, to: self.view.safeAreaLayoutGuide.top).top(0).leading(0).trailing(0)
        
        self.vBottom = self.view.createSubView()
        self.vBottom.make(labeled: "Bottom").top(0, to: self.view.safeAreaLayoutGuide.bottom).bottom(0).leading(0).trailing(0)
        
        self.vCenter = self.view.createSubView()
        self.vCenter.make(labeled: "Center").centerXY(offsets: .zero).width(100).height(150)
        
        self.vLeading = self.view.createSubView()
        self.vLeading.make(labeled: "Leading").leading(0).trailing(0, to: self.vCenter.leading).centerY(0, to: self.vCenter.centerY).height(100)
        
        self.vTrailing = self.view.createSubView()
        self.vTrailing.make(labeled: "Trailing").trailing(0).leading(0, to: self.vCenter.trailing).top(0, to: self.vCenter.top).height(100)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.vCenter.update().centerXY(offsets: CGPoint(x: 0, y: 100))
        self.vLeading.update().height(150)
        self.vTrailing.update().height(200)
    }
}
