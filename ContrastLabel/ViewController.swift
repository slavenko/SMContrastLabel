//
//  ViewController.swift
//  SMContrastLabel
//
//  Created by Slavenko on 12/30/18.
//  Copyright © 2018 Slavenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let HEIGHT:CGFloat = UIScreen.main.bounds.size.height
    let WIDTH:CGFloat = 150
    
    var constraint1: NSLayoutConstraint?
    var constraint2: NSLayoutConstraint?
    
    @IBAction func moveView(_ sender: Any) {
        constraint1?.isActive = false
		constraint1 = bgr.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: CGFloat.random(in: 1...UIScreen.main.bounds.size.width))
        constraint1?.isActive = true
        UIView.animate(withDuration: 2.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    lazy var contrastingLabel: SMContrastLabel = {
        let l = SMContrastLabel()
        l.translatesAutoresizingMaskIntoConstraints = false
		l.text = """
		Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.

		"""
        l.textAlignment = .center
		l.font = UIFont.systemFont(ofSize: 14)
        l.numberOfLines = 0
        l.minimumScaleFactor = 0.5
        l.adjustsFontSizeToFitWidth = true
        
        return l
    }()
    
    lazy var bgr : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        return v
    }()

	lazy var shape : CAShapeLayer = {
        let v = CAShapeLayer()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addContrastView()
        self.addContrastLabel()
    }
    
    func addContrastView()
    {
        //No one will ever need this, but hey, it was fun
        self.view.addSubview(bgr)
        constraint1?.isActive = true

		constraint1 = bgr.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        bgr.widthAnchor.constraint(equalToConstant: WIDTH).isActive = true
        bgr.heightAnchor.constraint(equalToConstant: HEIGHT).isActive = true
        bgr.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45).isActive = true
		view.sendSubviewToBack(bgr)
        //Obvously, this is important
        contrastingLabel.contrastView = bgr
    }
    
    func addContrastLabel()
    {
        //Why am I wasting time on this?
        self.view.addSubview(contrastingLabel)
        contrastingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contrastingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        contrastingLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contrastingLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        contrastingLabel.layoutIfNeeded()
    }
}

extension UIView {

    //Yeah at one point it would probably be a good idea to handle shapes/rotating views etc.
	func rotate(angle: CGFloat, duration: Double) {
        let radians = angle / 180.0 * CGFloat.pi
		let rotation = self.transform.rotated(by: radians)

		UIView.animate(withDuration: duration) {
			self.transform = rotation
		}
    }
}
