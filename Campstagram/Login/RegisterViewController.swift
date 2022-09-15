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
    
    var email: String = ""
    var name: String = ""
    var nickname: String = ""
    var password: String = ""
    
    var userInfo: ((UserInfo) -> Void)?
  
    
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
    
    @IBOutlet weak var popToLoginButton: UIButton!
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
        setupAttribute()
 
        
        //bug fix
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        

        
    }
    //MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){      self.view.endEditing(true)}
    @objc
    func textFieldEditingChanged(_ sender: UITextField){ //코드로 Action함수 대신  구현
        let text = sender.text ?? ""
        
        switch sender{
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
                
        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            //2글자 보다 많을때 true
            self.nickname = text
        case passwordTextField:
            self.isValidPassword = text.isValidPassword()
            self.password = text
        default:
            fatalError("Missing TextField...")
            
        }
        
    }
    
    @IBAction func registerButtonDidtap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        let userInfo = UserInfo(email: self.email, name: self.name, nickname: self.nickname, password: self.password)
        
        self.userInfo?(userInfo)
        
    }
    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
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
                self.signupButton.backgroundColor = UIColor.systemIndigo
                //                self.signupButton.backgroundColor = UIColor(named:"facebookColor")
            }
          
        }else{
            self.signupButton.isEnabled = false
            UIView.animate(withDuration:0.33){
            self.signupButton.backgroundColor = UIColor(named:"disabledButtonColor")
            }
        }
        
    }
    private func setupAttribute() {
        //registerButton
        
        let text1 = "계정이 있으신가요?"
        let text2 = "로그인"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.white
        let color2 = UIColor.systemIndigo
        let attributes = generateButtonAttribute(self.popToLoginButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.popToLoginButton.setAttributedTitle(attributes, for: .normal)
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

