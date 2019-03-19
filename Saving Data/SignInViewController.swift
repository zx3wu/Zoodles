//
//  SignInViewController.swift
//  Saving Data
//
//  Created by Nancy Wu on 2019-03-16.
//  Copyright © 2019 Nancy Wu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SignInViewController: UIViewController {
    
    var currentUsername = ""
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func nextButton(_ sender: Any) {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "username = %@", usernameField.text ?? "")
        
        guard let users = try! PersistenceService.context.fetch(fetchRequest) as? [Person] else { return }
        
        if users.isEmpty {
            let alert = UIAlertController(title: "Invalid username", message: "Please create an account", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            present(alert, animated: true, completion: nil)
        }
        
        users.forEach({ print($0.username) })
        
        
        for user in users {
            if user.username == usernameField.text && user.password == passwordField.text {
                //successful sign in
                currentUsername = usernameField.text ?? ""
                //let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "users")
                //self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
                
            } else {
                
                
                print("user \(user.username) and \(usernameField.text) dont match \(user.password )\(passwordField.text) ")
                let alert = UIAlertController(title: "Invalid username or password", message: nil, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                present(alert, animated: true, completion: nil)
                
                
            }
        }
        
        
        /*let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try  PersistenceService.context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                if data.value(forKey: "username") as! String  == usernameField.text {
                    print("valid username")
                }
                
            }
            
        } catch {
            
            print("Failed")
        }*/
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign In"
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        switch segue.identifier {
        case "showEventsViewController":
            guard let viewController = segue.destination as? ViewController else { return }
            viewController.currentUser = usernameField.text ?? ""
            print("name is \(usernameField.text)")
        default: break
        }
    }

}
