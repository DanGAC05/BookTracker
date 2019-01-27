//
//  BookViewController.swift
//  BookTracker
//
//  Created by Dan Chrest on 1/26/19.
//  Copyright © 2019 Dan Chrest. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bookImageView: UIImageView!
    
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }
    

    @IBAction func photosTapped(_ sender: Any) {
    
        imagePicker.sourceType = .photoLibrary
    
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            bookImageView.image = image
        
        bookImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
    
    
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        
        let book = Book(context: context)
        book.title = titleTextField.text
        book.image = bookImageView.image?.jpegData(compressionQuality: 1.0)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
    
        navigationController!.popViewController(animated: true)
    
    }
}

