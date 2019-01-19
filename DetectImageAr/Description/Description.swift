//
//  Description.swift
//  DetectImageAr
//
//  Created by claudio Cavalli on 19/01/2019.
//  Copyright © 2019 claudio Cavalli. All rights reserved.
//

import UIKit

class DescriptionView : UIView{
    
    
    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 347, height: 528))
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "Description", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    

    
    
}
