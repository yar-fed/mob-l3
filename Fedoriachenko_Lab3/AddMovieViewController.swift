//
//  AddMovieViewController.swift
//  Fedoriachenko_Lab3
//
//  Created by Yaroslav Fedoriachenko on 18.11.2020.
//

import UIKit

class AddMovieViewController: UIViewController {
    
    @IBOutlet weak var newMovieName: UITextField!
    @IBOutlet weak var newMovieYear: UITextField!
    @IBOutlet weak var newMovieType: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newMovieName.delegate = self
        newMovieYear.delegate = self
        newMovieType.delegate = self
        
        saveButton.isEnabled = false

        // Do any additional setup after loading the view.
    }
    
    func updateSaveButtonState() {
        let name = newMovieName.text ?? ""
        let year = newMovieYear.text ?? ""
        let type = newMovieType.text ?? ""
        saveButton.isEnabled = !name.isEmpty && !year.isEmpty && !type.isEmpty && Int(year) != nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateSaveButtonState()
        return true
    }


//    @IBAction func textEditingChanged(_ sender: UITextField) {
//        updateSaveButtonState()
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        newMovieYear.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ViewController

        let image = UIImage(named: "Poster_01")

        destVC.newMovie = Movie(image: image!, title: newMovieName.text ?? "", year: newMovieYear.text ?? "", type: newMovieType.text ?? "")
    }
}

extension AddMovieViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
