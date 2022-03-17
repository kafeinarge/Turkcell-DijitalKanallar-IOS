//
//  LoginViewController.swift
//  MoviesCatalog
//
//  Created by Samet Yatmaz on 15.03.2022.
//

import UIKit

public final class LoginViewController: UIViewController, StoryboardInstantiable {
    
    internal var viewModel: LoginViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var uiSwitch: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var viewVisit: UIView!
    @IBOutlet weak var viewWarning: UIView!
    @IBOutlet weak var lblWarning: UILabel!
    @IBOutlet weak var ConstraintWarning: NSLayoutConstraint!
    
    let username: String = "Username"
    let password: String = "Password"
    let cornerRadius: CGFloat = 5
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        settings()
    }
    
    
}

extension LoginViewController: LoginViewModelDelegate {
    public func handleViewModelOutput(_ output: LoginViewModelOutput) {
        switch output {
        case .updateTitle(let title):
            DispatchQueue.main.async {
                self.title = title
            }
        case .setRememberMe:
            guard let email = Constants.ud.string(forKey: username), let password = Constants.ud.string(forKey: password) else { return }
            guard !email.isEmpty, !password.isEmpty else { return }
          
            uiSwitch.isOn =  true
            txtEmail.text = email
            txtPassword.text = password
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.isHidden = !isLoading
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.isHidden = !isLoading
                    self.activityIndicator.stopAnimating()
                }
            }
            
        case .showLogin:
            DispatchQueue.main.async {
                if self.uiSwitch.isOn {
                    Constants.ud.set(self.txtEmail.text!, forKey: self.username)
                    Constants.ud.set(self.txtPassword.text!, forKey: self.password)
                    Constants.ud.synchronize()
                } else {
                    Constants.ud.removeObject(forKey: self.username)
                    Constants.ud.removeObject(forKey: self.password)
                    Constants.ud.synchronize()
                }
            }
        }
    }
    
    public func navigate(to route: LoginViewModelRoute) {
        switch route {
        case .search:
            DispatchQueue.main.async {
                app.router.startWithTabBar()
            }
        }
    }
    
    public func setWarningLabel(_ text: String?) {
        DispatchQueue.main.async(execute: {
            //Warning View Corner
            self.viewWarning.isHidden = false
            self.lblWarning.text = text
            self.ConstraintWarning.constant =  self.lblWarning.getTextSize().width + 40
            self.perform(#selector(self.setWarningViewHidden), with: text, afterDelay: 2.0)
        })
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtEmail:
            if txtEmail.text?.isEmpty == false {
                DispatchQueue.main.async {
                    self.txtPassword.becomeFirstResponder()
                }
            } else {
                textField.becomeFirstResponder()
            }
        case txtPassword:
            if txtPassword.text?.isEmpty == false {
                self.actionLogin()
            } else {
                textField.becomeFirstResponder()
            }
        default:
            break
        }
        return true
    }
}

extension LoginViewController {
    private func settings() {
        activityIndicator.isHidden = true
        viewWarning.layer.cornerRadius = cornerRadius
        viewWarning.layer.masksToBounds = true
        
        viewLogin.layer.cornerRadius = cornerRadius
        viewLogin.layer.masksToBounds = true
        viewLogin.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actionLogin)))
        
        viewVisit.layer.cornerRadius = cornerRadius
        viewVisit.layer.masksToBounds = true
        viewVisit.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actionVisit)))
    }
    
    @objc private func actionVisit() {
        let urlString = "https://www.themoviedb.org/login"
        do {
            let url = try URL(string: urlString).unwrap()
            UIApplication.shared.open(url)
        } catch {
            print(error)
        }
    }
    
    @objc private func actionLogin() {
        guard txtEmail.text?.count != 0 else {
            setWarningLabel("RequiredUsername".localized)
            return
        }
        
        guard txtEmail.text?.count != 0 else {
            setWarningLabel("RequiredPassword".localized)
            return
        }
        
        viewModel.login(email: txtEmail.text!, password: txtPassword.text!)
    }

   @objc private func setWarningViewHidden() {
        viewWarning.isHidden = true
    }
}

