//
//  ViewController.swift
//  ExpandableButtonExample
//
//  Created by Dima Mishchenko on 20.07.2018.
//  Copyright © 2018 Dima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var expandButton: UIButton!
    var buttonView: ExpandableButtonView!
    var buttonViewSelectedIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    @IBAction func expandButtonPressed(_ sender: Any) {
        if buttonView != nil && buttonView.state == .opened {
            self.buttonView.close()
            return
        }
        if buttonView != nil {
            buttonView.removeFromSuperview()
            buttonView = nil
        }
        let items = generateItems()
        buttonView = ExpandableButtonView(direction: .up, items: items)
        buttonView.openImage = nil
        buttonView.closeImage = nil
        buttonView.separatorColor = .clear
        buttonView.backColor = UIColor(named: "background_color")
        buttonView.layer.cornerRadius = 8
        buttonView.accessibilityIdentifier = "expandableButton"
        view.addSubview(buttonView)
        buttonView.frame = CGRect(x: expandButton.frame.origin.x - 4, y: expandButton.frame.origin.y - 8, width: 50, height: 40) // expandButton.frame
     
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.1) {
            self.buttonView.open()
        }
     
      
        
        
    }
    func generateItems() -> [ExpandableButtonItem] {
        return [
            ExpandableButtonItem(
                attributedTitle: NSAttributedString(string: "0.5x", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]),
                isSelected: buttonViewSelectedIndex == 0,
                action: { _ in
                    self.buttonViewSelectedIndex = 0
                    self.expandButton.setTitle("0.5x", for: .normal)
                    self.buttonView.close()
                }
            ),
            ExpandableButtonItem(
                attributedTitle: NSAttributedString(string: "1x", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]),
                isSelected: buttonViewSelectedIndex == 1,
                action: {_ in
                    self.buttonViewSelectedIndex = 1
                    self.expandButton.setTitle("1x", for: .normal)
                    self.buttonView.close()
                }
            ),
            ExpandableButtonItem(
                attributedTitle: NSAttributedString(string: "1.5x", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]),
                isSelected: buttonViewSelectedIndex == 2,
                action: { _ in
                    self.buttonViewSelectedIndex = 2
                    self.expandButton.setTitle("1.5x", for: .normal)
                    self.buttonView.close()
                }
            ),
            ExpandableButtonItem(
                attributedTitle: NSAttributedString(string: "2x", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]),
                isSelected: buttonViewSelectedIndex == 3,
                action: { _ in
                    self.buttonViewSelectedIndex = 3
                    self.expandButton.setTitle("2x", for: .normal)
                    self.buttonView.close()
                }
            ),
        ]
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.setupFrame()
        }, completion: nil)
    }

    private func setupFrame() {
        buttonView.frame = CGRect(x: 24, y: UIScreen.main.bounds.size.height - 24 - 80, width: 50, height: 40)
    }
}

extension UIImage {
    
    func alpha(_ value: CGFloat) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

