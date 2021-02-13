//
//  PushSaveManager.swift
//  GanifitDietgram
//
//  Created by 성준 on 2021/02/13.
//

import Foundation

class PushSaveManager {
    static let shared = PushSaveManager()
    
    private var leftData:[PshStack] = [
        PshStack(number: 0, text: "왼쪽 꼭대기 내용"),
                PshStack(number: 1, text: "2 내용"),
                PshStack(number: 2, text: "3 내용"),
                PshStack(number: 3, text: "4 내용"),
                PshStack(number: 4, text: "바닥 내용")
    ]
    
    private var rightData:[PshStack] = [
        PshStack(number: 0, text: "오른쪽 꼭대기 내용"),
                PshStack(number: 1, text: "2 내용"),
                PshStack(number: 2, text: "3 내용"),
                PshStack(number: 4, text: "바닥 내용")
    ]{
        didSet{
            print("dld?")
        }
    }
    
    func save(left:Bool, data:[PshStack]) {
        if left {
            leftData = []
            leftData = data
        } else {
            rightData = []
            rightData = data
        }
    }
    
    func get(left:Bool) -> [PshStack] {
        if left {
            return leftData
        } else {
            return rightData
        }
    }
    
    func save(left:Bool, data:PshStack, index:Int) {
        if left {
            leftData[index] = data
        } else {
            rightData[index] = data
        }
    }
    
}
