//
//  PushTextViewController.swift
//  GanifitDietgram
//
//  Created by 성준 on 2021/02/13.
//

import UIKit

class PushTextTableViewCell: UITableViewCell {
    @IBOutlet weak var lbNumber:UILabel!
    @IBOutlet weak var lbTextView:UITextView!
}

class PshStack :NSCoder{
    var number:Int
    var text:String
    
    init(number:Int, text:String) {
        self.number = number
        self.text = text
    }
}

class PushTextViewController: UIViewController {
    
    @IBOutlet weak var conTblBottom:NSLayoutConstraint!
    @IBOutlet weak var tblView:UITableView!
    
    var PsjDatas:[PshStack] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PsjDatas = PushSaveManager.shared.get(left: true)

        tblView.delegate = self
        tblView.dataSource = self
        
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            print("keyboardHeight = \(keyboardHeight)")
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                if let self = self {
                    self.conTblBottom.constant = keyboardHeight
                    self.view.layoutIfNeeded()
                }
            }
        } // 원하는 로직...
    }
        
    @objc func keyboardWillHide(_ notification:NSNotification) { // 원하는 로직...
        UIView.animate(withDuration: 0.3) { [weak self] in
            if let self = self {
                self.conTblBottom.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Action
    @IBAction func save(btn:UIButton) {
        let tg = btn.tag
        
        if tg == 0 {
            //왼쪽 상자
            print("왼쪽에 저장")
            PushSaveManager.shared.save(left: true, data: PsjDatas)
        } else {
            //오른족 상자
            print("오른쪽에 저장")
            
            let d = [
                PsjDatas[0],
                PsjDatas[1],
                PsjDatas[2],
                PsjDatas[3],
            ]
            PushSaveManager.shared.save(left: false, data: d)
        }
    }
}

extension PushTextViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        PsjDatas[textView.tag].text = textView.text
    }
}
// MARK: - TableView

extension PushTextViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PsjDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PushTextTableViewCell") as! PushTextTableViewCell
        cell.lbNumber.text = "\(PsjDatas[indexPath.row].number)"
        cell.lbTextView.tag = indexPath.row
        cell.lbTextView.delegate = self
        cell.lbTextView.text = PsjDatas[indexPath.row].text
        return cell
    }
}
