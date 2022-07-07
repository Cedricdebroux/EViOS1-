//
//  ViewController.swift
//  evaluation1
//
//  Created by cedric debroux on 07/07/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userImage : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userImage.makeRounded()
    }

}

extension UIImageView {
    
    func makeRounded() {
        
        
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
