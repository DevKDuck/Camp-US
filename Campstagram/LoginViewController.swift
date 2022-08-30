//
//  LoginViewController.swift
//  Campstagram
//
//  Created by duck on 2022/08/24.
//

import UIKit

class LoginViewController: UIViewController {
    var email = String()
    var password = String()
    var userInfo: UserInfo?

    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAttribute()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){      self.view.endEditing(true)}
    
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) { //event를 Editing Changed로 줌 - 텍스트필드의 값이 변경될때마다 메소드가 호출됨
        let text = sender.text ?? ""   //옵셔널 형식으로 반환됨
        self.loginButton.backgroundColor = text.isValidEmail() ? UIColor(named: "facebookColor") : UIColor(named: "disabledButtonColor")
        
        self.email = text
    }
    
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.loginButton.backgroundColor = text.count > 2 ? UIColor(named: "facebookColor") : UIColor(named: "disabledButtonColor")
        
        self.password = text
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
    //로그인
        //회원가입정보를 전달받아서, TextField 데이터와 일치하면 로그인됨
        guard let userInfo = userInfo else { return }
        if userInfo.email == self.email && userInfo.password == self.password{
            let goVC = storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as! UITabBarController
            goVC.modalPresentationStyle = .fullScreen
            self.present(goVC, animated: true)
        }else{
   
        }
        
        
    }
    
     @IBAction func registerButtonDidTap(_ sender: UIButton) {
         //회원가입
         //화면전환
         //1. 스토리보드를 생성
         let storyboard = UIStoryboard(name:"Main", bundle: nil)
         //2. 뷰컨트롤러 생성
         let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
         //3.화면전환 메소드 사용
         //애니메이션은 애니메이션 유무 컴플리션은 화면전환 이후 필요한 동작
//         self.present(registerViewController, animated: true, completion: nil)
         self.navigationController?.pushViewController(registerViewController, animated: true)
         //수직적인 내용들 상세적인 내용들 사용할때 네이게이션 뷰 많이 사용
         
         registerViewController.userInfo = { [weak self](userInfo) in
             self?.userInfo = userInfo
         }

     }
    private func setupAttribute() {
        //registerButton
        
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor(named: "facebookColor") ?? .blue
        
        let attributes = generateButtonAttribute(self.registerButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.registerButton.setAttributedTitle(attributes, for: .normal)
    }

}
