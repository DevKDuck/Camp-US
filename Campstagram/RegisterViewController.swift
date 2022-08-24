//
//  RegisterViewController.swift
//  Campstagram
//
//  Created by duck on 2022/08/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    //유효성을 검사하기 위한 프로퍼티 4개를 생성
    var isValidEmail = false
    
    var isValidName = false
    
    var isValidNickname = false
    
    var isValidPassword = false
    
    
    //TextField를 IBOutlet으로 가져옴
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
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
            print("email")
        case nameTextField:
            print("name")
            
        case nicknameTextField:
            print("nickname")
            
        case passwordTextField:
            print("password")
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
    
    
}
