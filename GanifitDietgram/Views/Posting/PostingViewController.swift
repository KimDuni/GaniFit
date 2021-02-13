//
//  PostingViewController.swift
//  GanifitDietgram
//
//  Created by 성준 on 2021/02/05.
//

import UIKit

//extension Error {
//    case FailToPush
//}


protocol PostingViewModelInput {
    func pushStack()
    func popStack(with _: Int)
}

protocol PostingViewModelOutput {
//    var title: String { get }
//    var isPosterImageHidden: Bool { get }
//    var overview: String { get }
}

class PostingViewModel: PostingViewModelInput {
    
    var ganiStack:[String] = []
    
    private let maxStack:Int = 5
    
    func pushStack() {
        if maxStack == ganiStack.count {
            
        }
    }
    
    func popStack(with _: Int) {
        
    }
}

class PostingViewController: UIViewController, StoryboardInstantiable {
    
//    private var disposeBag:DisposeBag = DisposeBag()
    
    @IBOutlet weak var btnPushStack:UIButton!
    
    @IBOutlet weak var btnPopStack:UIButton!
    
    @IBOutlet weak var vStack:UIStackView!{
        didSet {
            vStack.axis = .vertical
            vStack.layer.cornerRadius = 5
            vStack.layer.borderWidth = 1.3
            vStack.layer.borderColor = UIColor.basePink!.cgColor
            vStack.distribution = .fillEqually
            vStack.clipsToBounds = true
            vStack.spacing = 1
        }
    }
    
    @IBOutlet weak var viewBoardContainer:UIView!
    
    var viewInputBoard:UIView!
    
    var tvInBoard:UITextView!
    
    var stackPointer:StackPointer!
    
    private let defStackCnt:Int = 3
    private var viewMode:PostingViewModel!
    
    static func create() -> PostingViewController {
        let view = PostingViewController.instantiateViewController()
        return view
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.createBoard()
            }
        }
    }
    
    private func setupUI() {
        
        stackPointer = StackPointer(frame: CGRect(x: vStack.bounds.width + 12,
                                                  y: vStack.frame.origin.y + (vStack.bounds.height / 3 - (vStack.bounds.height / 3) / 2),
                                                  width: 15, height: 15))
        self.view.addSubview(stackPointer)
        
//        btnPushStack.rx.tap
//            .asDriver()
//            .drive(onNext: { [weak self] in
//                guard let weakSelf = self else { return }
//
//                weakSelf.addPush(weakSelf.vStack.arrangedSubviews.count)
//            }).disposed(by: disposeBag)
        
        for index in 0 ..< defStackCnt {
            addPush(index)
        }
    }
    
    var currentPos:Int = 0
    
    private func addPush(_ index:Int) {
        
        let view = UIView()
        view.backgroundColor = UIColor.basePink
        view.tag = index
        vStack.addArrangedSubview(view)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapStack))
        view.addGestureRecognizer(tap)
    }
    
    private func moveStackPointer(_ index:Int) {

        currentPos = index
        
        let subViewCnt = CGFloat(vStack.arrangedSubviews.count)
        let subViewHeight = vStack.bounds.height / subViewCnt
        let subViewHeightHalf = subViewHeight / 2
        let transY = vStack.frame.origin.y + (subViewHeight * CGFloat( index ) + subViewHeightHalf)
        
        UIView.animate(withDuration: 0.2) {[weak self] in
            if let self = self {
                self.stackPointer.frame.origin.y = transY
            }
        }
        
        animateTab()
    }
    
    @objc func tapStack(tap:UITapGestureRecognizer) {
        
        guard let tapTag = tap.view?.tag else { return }
        moveStackPointer(tapTag)
    }
    
    func createBoard() {
        
        let board = UIView()
        board.frame = CGRect(x: viewBoardContainer.bounds.midX - 120,
                             y: viewBoardContainer.bounds.midY - 40,
                             width: 240, height: 80)
        board.backgroundColor = UIColor.basePink
        viewInputBoard = board
        viewBoardContainer.addSubview(board)
        
        let textView = UITextView(frame: viewInputBoard.bounds)
        textView.text = "^_^"
        textView.backgroundColor = .clear
        viewInputBoard.addSubview(textView)
        
        animateTab()
        //입력바람
    }
    
    
    func animateTab(){
        
        self.viewInputBoard.frame = CGRect(x: viewBoardContainer.bounds.midX - 120,
                                     y: viewBoardContainer.bounds.midY - 40,
                                     width: 240, height: 80)
        
//        UIView.animate(withDuration: 0.1) {
            
//        }
        
//        UIView.animate(withDuration: 0.65,
//                               delay: 0.0,
//                               usingSpringWithDamping: 0.35,
//                               initialSpringVelocity: 0.6) { [weak self] in
//            if let self = self {
//                self.viewInputBoard.frame = CGRect(x: self.viewBoardContainer.bounds.midX - 150,
//                                     y: self.viewBoardContainer.bounds.midY - 75,
//                                     width: 300, height: 150)
//            }
//        }
    }
}
