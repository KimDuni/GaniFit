//
//  PostingViewController.swift
//  GanifitDietgram
//
//  Created by 성준 on 2021/02/05.
//

import UIKit

struct AppSize {
    static let screenBounds = UIScreen.main.bounds
    static let screenWidth = AppSize.screenBounds.width
    static let screenHeigt = AppSize.screenBounds.height
    static let screenW_Half = AppSize.screenWidth / 2
    static let screenH_Half = AppSize.screenHeigt / 2
}

class PostingViewController: UIViewController {
    
    @IBOutlet weak var btnPushStack:UIButton!
    
    @IBOutlet weak var btnPopStack:UIButton!
    
    @IBOutlet weak var vStack:UIStackView!{
        didSet {
            vStack.axis = .vertical
            vStack.layer.cornerRadius = 5
            vStack.layer.borderWidth = 1.3
            vStack.layer.borderColor = UIColor(named: "BaseColor")!.cgColor
        }
    }
    
    @IBOutlet weak var viewBoardContainer:UIView!
    
    var viewInputBoard:UIView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.createBoard()
            }
        }
    }
    
    func createBoard(){
        
        let board = UIView()
        board.frame = CGRect(x: viewBoardContainer.bounds.midX - 120, y: viewBoardContainer.bounds.midY - 40, width: 240, height: 80)
        board.backgroundColor = .black
        viewBoardContainer.addSubview(board)
        
        UIView.animate(withDuration: 0.65,
                               delay: 0.0,
                               usingSpringWithDamping: 0.35,
                               initialSpringVelocity: 0.6) { [weak self] in
            if let self = self {
                board.frame = CGRect(x: self.viewBoardContainer.bounds.midX - 150,
                                     y: self.viewBoardContainer.bounds.midY - 50,
                                     width: 300, height: 100)
            }
        }
        
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
