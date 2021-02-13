//
//  ResultViewController.swift
//  GanifitDietgram
//
//  Created by 성준 on 2021/02/13.
//

import UIKit

class ResultViewController: UIViewController {

    
    @IBOutlet var leftTxtViews:[UITextView]!
    @IBOutlet var rightTxtViews:[UITextView]!
    @IBOutlet weak var btnIcon:UIButton!
    @IBOutlet weak var lbDate:UILabel!
    @IBOutlet weak var lbDDay:UILabel!
    @IBOutlet weak var viewDDay:UIView!{
        didSet {
            viewDDay.layer.borderColor = UIColor(named: "BaseGray")?.cgColor
            viewDDay.layer.borderWidth = 0.3
        }
    }
    
    @IBOutlet weak var lbPTCnt:UILabel! {
        didSet {
            lbPTCnt.isHidden = true
        }
    }
    @IBOutlet weak var vPTCnt:UIView! {
        didSet {
            vPTCnt.isHidden = true
            vPTCnt.layer.borderColor = UIColor(named: "BaseGray")?.cgColor
            vPTCnt.layer.borderWidth = 0.3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let leftDatas = PushSaveManager.shared.get(left: true)
        
        for (index, left) in leftDatas.enumerated() {
            leftTxtViews[index].text = left.text
        }
        
        let rightDatas = PushSaveManager.shared.get(left: false)
        
        for (index, right) in rightDatas.enumerated() {
            rightTxtViews[index].text = right.text
        }
    }
    
    
    var cnt:String? = "0"
    @IBAction func dd() {
        
        let alert = UIAlertController(title: "골라라", message: "피티회차입력? or 내용입력.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "회차입력", style: .default) { (a) in
            self.editCnt()
            alert.dismiss(animated: true, completion: nil)
        }
        
        let edittxt = UIAlertAction(title: "내용입력", style: .default) { (a) in
            let dt = PushSaveManager.shared.get(left: false)[2]
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "edit", sender: (2, dt.text, false))
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (a) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        alert.addAction(edittxt)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func editCnt() {
        let alert = UIAlertController(title: "피티몇회차임?", message: "숫자만 입력해라.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { [weak self] tf in
            if let self = self {
                if self.cnt != "0" {
                    tf.placeholder = "회차입력 안하려면 숫자 0 입력해라"
                }
            }
        })
        
        let ok = UIAlertAction(title: "화긴", style: .default) { (a) in
            
            self.cnt =  alert.textFields?[0].text
            
            if self.cnt != "0" {
                self.vPTCnt.isHidden = false
                self.lbPTCnt.isHidden = false
                self.lbPTCnt.text = "PT \(self.cnt!)회차"
            } else {
                self.lbPTCnt.isHidden = true
                self.vPTCnt.isHidden = true
            }
            alert.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (a) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func editLeft(btn:UIButton) {
        
        let dt = PushSaveManager.shared.get(left: true)[btn.tag]
        performSegue(withIdentifier: "edit", sender: (btn.tag, dt.text, true))
        
    }
    
    @IBAction func editRight(btn:UIButton) {
        let dt = PushSaveManager.shared.get(left: false)[btn.tag]
        performSegue(withIdentifier: "edit", sender: (btn.tag, dt.text, false))
    }
    
    @IBAction func editDate() {
        
        let alert = UIAlertController(title: "오늘날짜입력", message: "자동입력되게 작업중임 불편하지만 일단 쓰셈", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let ok = UIAlertAction(title: "화긴", style: .default) { (a) in
            
            self.lbDate.text = alert.textFields?[0].text
            alert.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (a) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editDDay() {
        
        let alert = UIAlertController(title: "D-Day입력", message: "남은 기간 숫자만 입력 \nex) 백일 남은 경우 100", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let ok = UIAlertAction(title: "화긴", style: .default) { (a) in
            
            self.lbDDay.text = "D-\(alert.textFields![0].text!)"
            alert.dismiss(animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { (a) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! EditViewController
        vc.editTarget = (sender as! (Int, String, Bool))
        vc.delegate = self
    }
    
    
}

extension ResultViewController: EditViewControllerDelegate {
    func editComplete() {
        viewWillAppear(true)
    }
}
