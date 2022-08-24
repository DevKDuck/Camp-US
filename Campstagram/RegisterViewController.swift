//
//  RegisterViewController.swift
//  Campstagram
//
//  Created by duck on 2022/08/24.
//

import UIKit
import Foundation

class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    //유효성을 검사하기 위한 프로퍼티 4개를 생성
    var isValidEmail = false{
        didSet{ //셋팅 후에 코드블럭 실행 didSet
            self.validateUserInfo()
        } //isValidEmail에서 값을 입력 받을때마다 호출함 - 프로퍼티 옵져버
    }
    
    var isValidName = false{
        didSet{
            self.validateUserInfo()
        }
    }
    
    var isValidNickname = false{
        didSet{
            self.validateUserInfo()
        }
    }
    
    var isValidPassword = false{
        didSet{
            self.validateUserInfo()
        }
    }
    
    
    //TextField를 IBOutlet으로 가져옴
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    var textFields: [UITextField]{
        [emailTextField,nameTextField,nicknameTextField,passwordTextField]
    } //연산 프로퍼티로 한번에 접근할 수 있도록함
    
    
    //MARK: - LifeCyecle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextField()
        
    }
    //MARK: - Actions
    @objc
    func textFieldEditingChanged(_ sender: UITextField){ //코드로 Action함수 대신  구현
        let text = sender.text ?? ""
        
        switch sender{
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
                
        case nameTextField:
            self.isValidName = text.count > 2
            
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            //2글자 보다 많을때 true
            
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
        default:
            fatalError("Missing TextField...")
            
        }
        
    }
    
    
    
    
    //MARK: - Helpers
    private func setUpTextField() {
        
        textFields.forEach{ tf in
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
            
        } //textFields와 Action을 연결
        
        
    }
    
    //사용자가 입력한 회원정보를 확인하고 -> UI업데이트
    private func validateUserInfo(){
        if isValidEmail && isValidName && isValidNickname && isValidPassword{
            self.signupButton.isEnabled = true
            UIView.animate(withDuration:0.33){
                self.signupButton.backgroundColor = UIColor(named:"facebookColor")
            }
          
        }else{
            self.signupButton.isEnabled = false
            UIView.animate(withDuration:0.33){
            self.signupButton.backgroundColor = UIColor(named:"disabledButtonColor")
            }
        }
        
    }
    
    
}

//정규표현식
extension String{
    //대문자, 소문자, 특수문자, 숫자 8자 이상일떄, ->True
    func isValidPassword() -> Bool{
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    //@ 2글자
    func isValidEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

