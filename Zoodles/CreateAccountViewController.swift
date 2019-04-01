//
//  CreateAccountViewController.swift
//  Saving Data
//
//  Created by Nancy Wu on 2019-03-16.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CreateAccountViewController: UIViewController {
    

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var currentUser: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Acccount"
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hideKeyboardWhenTappedAround()
        self.navigationController!.navigationBar.topItem!.title = "Sign In"
    }

    
    
    @IBAction func createAccountTapped(_ sender: Any) {
        //let alert = UIAlertController(title: "Account Created", message: nil, preferredStyle: .alert)
    
        
            let person = Person(context: PersistenceService.context)
            person.username = userNameField.text
        person.email = emailField.text
        person.password = passwordField.text
            PersistenceService.saveContext()
        print("saved user")
        
        currentUser = userNameField.text ?? ""

        //alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))/*{ (action) -> Void in
           // let viewController = self.storyboard?.instantiateViewController(withIdentifier: "users")
            //self.navigationController?.pushViewController(viewController!, animated: true)
            
    //}))

        
        //present(alert, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "showEventsViewControllerFromCreate":
            guard let viewController = segue.destination as? ViewController else { return }
            viewController.currentUser = userNameField.text ?? ""
            print("name is \(userNameField.text)")
        default: break
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
