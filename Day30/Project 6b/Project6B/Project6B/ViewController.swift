//
//  ViewController.swift
//  Project6B
//
//  Created by Muhammad Usman Tatla on 17/12/2019.
//  Copyright © 2019 Zafus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "These"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .green
        label2.text = "Are"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "Some"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .brown
        label4.text = "Awesome"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .blue
        label5.text = "Labels"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewsDict = ["label1": label1,
                         "label2": label2,
                         "label3": label3,
                         "label4": label4,
                         "label5": label5]
        for label in viewsDict.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDict))
        }
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-44-[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDict))
        
    }


}

