//
//  ViewController.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 04/11/2020.
//

import UIKit

class LoginViewController: UIViewController {
    private var viewModel: LoginViewModel!
    let usernameTextField = UITextField(frame: .zero)
    let passwordTextField = UITextField(frame: .zero)
    
    private var coordinator: ProjectCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBehaviours()
        bind(to: viewModel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    var traverse: Bool? {
        didSet {
             coordinator?.moveToList()
        }
    }
    
    var myError: Error? {
        didSet {
            viewModel.cancelCall()
            self.showNotification(title: "An error occured", message: "\(myError!.localizedDescription)", completion: nil)
        }
    }
    
    lazy var loginButton: UIButton = {
        let butt = UIButton(frame: .zero)
        butt.setTitle("Login", for: .normal)
        butt.setTitleColor(.blue, for: .normal)
        butt.setTitleColor(.gray, for: .disabled)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.addTarget(self, action: #selector(self.loginAction), for: .touchDown)
        return butt
    }()
    
    lazy var controlsStack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        return stack
    }()
    
    @objc func loginAction() {
        viewModel.loginNetworkCall()
    }

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        self.view = view
        
        self.view.addSubview(controlsStack)
        
        usernameTextField.backgroundColor = .white
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.layer.borderColor = UIColor.systemGray4.cgColor
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.placeholder = "username"
        usernameTextField.autocapitalizationType = .none
        usernameTextField.spellCheckingType = .no
        usernameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: usernameTextField.frame.height))
        usernameTextField.leftViewMode = .always
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        controlsStack.addArrangedSubview(usernameTextField)
        
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderColor = UIColor.systemGray4.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.placeholder = "password"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.spellCheckingType = .no
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false

        controlsStack.addArrangedSubview(passwordTextField)
        controlsStack.addArrangedSubview(loginButton)
        
        NSLayoutConstraint.activate([
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            controlsStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            controlsStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controlsStack.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5),
            controlsStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    init(coordinator: ProjectCoordinator, viewModel: LoginViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bind(to viewModel: LoginViewModel) {
        viewModel.userNameBindable.bind(\String.self, to: usernameTextField, \.text)
        viewModel.passwordBindable.bind(\String.self, to: passwordTextField, \.text)
        viewModel.errorBindable.bind(\Error.self, to: self, \.myError)
        viewModel.loginBindable.bind(\Bool.self, to: self, \.traverse)
        viewModel.viewEnabledBindable.bind(\Bool.self, to: loginButton, \.isEnabled)
        viewModel.viewEnabledBindable.bind(\Bool.self, to: self, \.loading)
    }
    
    var loading: Bool? {
        didSet {
            if let loading = loading, !loading {
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.startIndicatingActivity()
            } else {
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.stopIndicatingActivity()
            }
        }
    }
    
    private func setupBehaviours() {
        addBehaviors([HideNavigationBarBehavior()])
    }
}
