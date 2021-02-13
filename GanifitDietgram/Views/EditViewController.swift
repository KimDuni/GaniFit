//
//  EditViewController.swift
//  GanifitDietgram
//
//  Created by 성준 on 2021/02/13.
//

import UIKit

protocol EditViewControllerDelegate:class {
    func editComplete()
}

class EditViewController: UIViewController {
    
    weak var delegate:EditViewControllerDelegate? = nil
    @IBOutlet weak var tv:UITextView!

    typealias index = Int
    typealias origin = String
    typealias left = Bool
    
    var editTarget:(index,origin,left)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tv.text = editTarget.1
    }
    

    @IBAction func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save() {
        
        PushSaveManager.shared.save(left: editTarget.2, data: PshStack(number: editTarget.0, text: tv.text), index: editTarget.0)
        delegate?.editComplete()
        self.dismiss(animated: true, completion: nil)
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
