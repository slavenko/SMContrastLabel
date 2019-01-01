//
//  ViewController.swift
//  ContrastLabel
//
//  Created by Slavenko on 1/1/19.
//  Copyright © 2019 Slavenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let HEIGHT:CGFloat = 100
    let WIDTH:CGFloat = 100
    
    lazy var label: ContrastLabel = {
        let l = ContrastLabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "CONTRAST"
        l.textAlignment = .center
        l.font = UIFont.boldSystemFont(ofSize: 35)
        l.numberOfLines = 0
        l.minimumScaleFactor = 0.5
        l.adjustsFontSizeToFitWidth = true
        
        return l
    }()
    
    lazy var bgr : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //just a proof of concept
        //self.addContrastView()
        self.addContrastLabel()
    }
    
    func addContrastView()
    {
        //No one will ever need this, but hey, it was fun
        self.view.addSubview(bgr)
        bgr.widthAnchor.constraint(equalToConstant: WIDTH).isActive = true
        bgr.heightAnchor.constraint(equalToConstant: HEIGHT).isActive = true
        bgr.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 70).isActive = true
        bgr.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45).isActive = true
        
        //Obvously, this is important
        label.contrastView = bgr
    }
    
    func addContrastLabel()
    {
        //Why am I wasting time on this?
        self.view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        label.layoutIfNeeded()
    }
}

