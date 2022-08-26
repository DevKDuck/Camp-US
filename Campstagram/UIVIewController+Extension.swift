//
//  UIVIewController+Extension.swift
//  Campstagram
//
//  Created by duck on 2022/08/26.
//

import UIKit

extension UIViewController{
    func generateButtonAttribute(_ button: UIButton,texts: String...,fonts: UIFont...,colors: UIColor...) -> NSMutableAttributedString{
        //버튼,텍스트,폰트,색깔(복수형)을 받아서 아래 코드 로직을 처리해서 어떤 속성이 적용된 문자열로 리턴하는 함수
        
        //UIButton에 입력된 text를 가져온다.
        guard let wholeText = button.titleLabel?.text else {
            fatalError("버튼에 텍스트가 없음.")
        }
        
        //폰트들
        let cusomFonts: [UIFont] = fonts
        
        //설정하고자 하는 String의 NSRanges
        let customTextsRanges = texts.indices.map{ index in
            (wholeText as NSString).range(of: texts[index])
        }
        
        //설정하고자 하는 색상들
        let cusomColors = colors
        
        // attribute 객체를 생성한다.
        let attributedString = NSMutableAttributedString(string: wholeText)
        
        //텍스트에 맞는 설정을 추가한다.
        texts.indices.forEach { index in
            attributedString.addAttribute(.font,
                                           value: cusomFonts[index],
                                           range: customTextsRanges[index])
            
            attributedString.addAttribute(.foregroundColor,
                                           value: cusomColors[index],
                                           range: customTextsRanges[index])
        }
        return attributedString
    }
}

