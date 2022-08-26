//
//  UIView+Extension.swift
//  Campstagram
//
//  Created by duck on 2022/08/26.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        // 모서리부분
        //interface builder에 Inspectable 항목을 추가하는 것
        get{
            return layer.cornerRadius
            //값을 읽어 올때에는 레이어의 둥글기의 수치를 가져옴
        }
        set{
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
            //값을 세팅할때에는 newValue 값을 받을 거고 그 값을 해당 UIView에 넣어줄 것임 
        }
    }
}
