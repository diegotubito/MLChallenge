//
//  XibView.swift
//  MLChallenge
//
//  Created by David Diego Gomez on 17/09/2020.
//

import UIKit

class XibView: UIView {
    var xibName : String?
    
    override init(frame frameRect: CGRect) {
        super .init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        loadNibFile()
        commonInit()
    }
    
    internal func commonInit() {
        
    }
    
    internal func loadNibFile() {
        let xibName = self.xibName ?? String(describing: type(of: self))
        if let objects = Bundle.main.loadNibNamed(xibName, owner: self, options: nil) {
            if let myView = objects.first(where: { $0 is UIView } ) as? UIView {
                myView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
                addSubview(myView)
            }
        }
    }
   
    func removeView() {
        self.removeFromSuperview()
    }
}



