//
//  ViewController.swift
//  Marathon6thTask
//
//  Created by Артем Соколовский on 16.07.2023.
//

import UIKit

class ViewController: UIViewController {
	
	lazy var squareView: UIView = {
		
		let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
		view.backgroundColor = .systemBlue
		view.center = self.view.center
		view.layer.cornerRadius = 8
		return view
		
	}()
	
	var animator = UIDynamicAnimator()
	var snapBehavior: UISnapBehavior?

	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		addGestureRecognizer()
		view.addSubview(squareView)
		addAnimatorAndBehaviors()
	
	}

	func addGestureRecognizer() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(paramTap:)))
		view.addGestureRecognizer(tap)
	}

	func addAnimatorAndBehaviors() {
		
		animator = UIDynamicAnimator(referenceView: view)
		let collision = UICollisionBehavior(items: [squareView])
		collision.translatesReferenceBoundsIntoBoundary = true
		animator.addBehavior(collision)
		
		snapBehavior = UISnapBehavior(item: squareView, snapTo: squareView.center)
		snapBehavior?.damping = 0.5
		animator.addBehavior(snapBehavior!)
	}
	
	@objc func handleTap(paramTap: UIGestureRecognizer) {
		let tapPoint = paramTap.location(in: view)
		
		if snapBehavior != nil {
			animator.removeBehavior(snapBehavior!)
		}
		
		snapBehavior = UISnapBehavior(item: squareView, snapTo: tapPoint)
		snapBehavior?.damping = 1.0
		animator.addBehavior(snapBehavior!)
	}
}

