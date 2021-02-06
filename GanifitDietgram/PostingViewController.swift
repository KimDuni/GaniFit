//
//  PostingViewController.swift
//  GanifitDietgram
//
//  Created by 성준 on 2021/02/05.
//

import UIKit

class PostingViewController: UIViewController {

    @IBOutlet weak var vStack:UIStackView!{
        didSet {
            vStack.axis = .vertical
            vStack.layer.cornerRadius = 10
            vStack.layer.borderWidth = 1
            vStack.layer.borderColor = UIColor(named: "BaseColor")!.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
