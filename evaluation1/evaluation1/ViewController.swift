//
//  ViewController.swift
//  evaluation1
//
//  Created by cedric debroux on 07/07/2022.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet var userImage : UIImageView!
    @IBOutlet var passwordField : UITextField!
    @IBOutlet var passwordImage : UIImageView!
    @IBOutlet var login : UITextField!
    @IBOutlet var switchButton : UISwitch!
    @IBOutlet var uiIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        uiIndicator.isHidden = true
        super.viewDidLoad()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(changeviewPassword))
        passwordImage.addGestureRecognizer(recognizer)
        login.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userImage.makeRounded()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }

    @objc func changeviewPassword(){
        
        if passwordField.isSecureTextEntry == true {
            passwordField.isSecureTextEntry = false
            passwordImage.image = UIImage(named: "eye_off_icon")
        }else {
            passwordField.isSecureTextEntry = true
            passwordImage.image = UIImage(named: "eye_on_icon")
        }
    }
    
    @IBAction func saveContact(){
        print("Le login est : \(login.text ?? "")")
        print("Le mot de passe : \(passwordField.text ?? "")")
        print("La newletter est coché \(switchButton.isOn)")
    }
    
    func showAlert() {
        if switchButton.isOn == true{
            let alert = UIAlertController(title: "Bienvenue \(login.text ?? "")", message: "Vous vous êtes inscrit à la newletter", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Merci !", style: .default, handler: nil))
               present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Bienvenue \(login.text ?? "")", message: "Vous  n'êtes pas inscrit à la newletter", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "Merci !", style: .default, handler: nil))
               present(alert, animated: true)
        }
       }
    func showError(){
        let alert = UIAlertController(title: "ERROR", message: "Une condition n'est pas respecté", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
           present(alert, animated: true)
    }
    
    @IBAction func show(){
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
       
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if predicate.evaluate(with: login.text) && passwordField.text?.count ?? 0 >= 4 {
            performLogin()
        } else{
            showError()
        }
            
    }
    
    func performLogin(){
    
        DispatchQueue.global(qos: .background).async{
            DispatchQueue.main.async {
                self.uiIndicator.isHidden = false
                self.uiIndicator.startAnimating()
            }
            sleep(3)
            DispatchQueue.main.async {
                self.showAlert()
                self.uiIndicator.isHidden = true
                self.uiIndicator.stopAnimating()
            }
        }
    }

}


extension UIImageView {
    
    func makeRounded() {
        
        
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
extension ViewController: UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField)->Bool{
        if textField == login{
            passwordField.becomeFirstResponder()
        }else if (textField == passwordField){
            view.endEditing(true)
        }
        

        return true
    }
}
