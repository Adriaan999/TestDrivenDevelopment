//
//  SignUpViewController.swift
//  PhotoApp
//
//  Created by Adriaan van Schalkwyk on 2021/03/26.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var signUpPresenter: SignUpPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if signUpPresenter == nil {
            let signUpModelValidator = SignUpFormModelValidator()
            let webservice = SignUpWebService(urlString: SignUpConstants.signupURLString)
            signUpPresenter = SignUpPresenter(formModelValidator: signUpModelValidator, webService: webservice, delegate: self)
        }
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let signUpFromModel = SignUpFromModel(firstName: userFirstNameTextField.text ?? "",
                                              lastName: lastNameTextField.text ?? "",
                                              email: emailTextField.text ?? "",
                                              password: passwordTextField.text ?? "",
                                              repeatPassowrd: repeatPasswordTextField.text ?? "")
        signUpPresenter?.proccessUserSignUp(fromModel: signUpFromModel)
    }
}

extension SignUpViewController: SignUpViewDelegateProtocol {
    
    func successfullSignUp() {
        let alert = UIAlertController(title: "Success",
                                      message: "Login success",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alert, animated: true, completion: nil)
        }    }
    
    func errorHandler(error: SignUpErrors) {
        let alert = UIAlertController(title: "Error",
                                      message: "Your request could not be processed at this time",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true, completion: nil)
        }
    }
}
