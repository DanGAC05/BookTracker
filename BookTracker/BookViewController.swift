//
//  BookViewController.swift
//  BookTracker
//
//  Created by Dan Chrest on 1/26/19.
//  Copyright © 2019 Dan Chrest. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addupdatebutton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bookImageView: UIImageView!
    
    
    var imagePicker = UIImagePickerController()
    var book : Book? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if book != nil {
            bookImageView.image = UIImage(data: book!.image as! Data)
            titleTextField.text = book!.title
            addupdatebutton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }

    @IBAction func photosTapped(_ sender: Any) {
    
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            bookImageView.image = image
            imagePicker.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)   
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if book != nil {
            book!.title = titleTextField.text
            book!.image = bookImageView.image?.jpegData(compressionQuality: 1.0)
        } else {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let book = Book(context: context)
                book.title = titleTextField.text
                book.image = bookImageView.image?.jpegData(compressionQuality: 1.0)
        }
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }
    
        navigationController!.popViewController(animated: true)
    
    }

    @IBAction func deleteTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {

            context.delete(book!)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            navigationController!.popViewController(animated: true)
        
        }
    }
}

