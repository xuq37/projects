//
//  ViewController.swift
//  Xu_Jack_Memory
//
//  Created by Period Four on 2018-04-23.
//  Copyright © 2018 Period Four. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //set a variable to represent the game mode
    var viewNumber = 0
    //Set the viewNumber to 1 if single plyer mode is selected
    @IBAction func Single(_ sender: Any) {
        viewNumber = 1
    }
    //Set the viewNumber to 2 if time mode is selected
    @IBAction func Time(_ sender: Any) {
        viewNumber = 2
    }
    //Set the viewNumber to 3 if double plyer mode is selected
    @IBAction func Double(_ sender: Any) {
        viewNumber = 3
        
        
    }
    

        
    
    
    //Transfer the mode number to the NMviewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if viewNumber == 1 || viewNumber == 2 || viewNumber == 3 {
        let i = segue.destination as! NMViewController
            i.modenum = viewNumber
            viewNumber = 0
        }
    }
    //Show the rules when it is clicked
    @IBAction func RuleBtn(_ sender: Any) {
        performSegue(withIdentifier: "RViewController", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Disable the two player mode at starte.
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

