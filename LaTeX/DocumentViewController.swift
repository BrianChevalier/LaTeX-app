//
//  DocumentViewController.swift
//  LaTeX
//
//  Created by Brian Chevalier on 6/11/19.
//  Copyright © 2019 Brian Chevalier. All rights reserved.
//

import UIKit
import ios_system


class DocumentViewController: UIViewController {
    
    @IBOutlet weak var documentNameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleView: UINavigationItem!
    
    var document: Document?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        // Access the document
        textView.text = ""
        
        document?.open(completionHandler: { [weak self] (success) in
            
            guard let `self` = self else {
                return
            }
            
            if success {
                
                // Display the content of the document, e.g.:
                self.textView.text = self.document?.text
                
                //self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
              
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        
        
        // Save the document
        let currentText = self.document?.text ?? ""
        
        self.document?.text = self.textView.text
        
        if currentText != self.textView.text {
            self.document?.updateChangeCount(.done)
        }

        // Close the document
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
        
    }
    
    @IBAction func buildLaTeXFile(){
        
        // Save the document
        let currentText = self.document?.text ?? ""
        
        self.document?.text = self.textView.text
        
        if currentText != self.textView.text {
            self.document?.updateChangeCount(.done)
        }
        
        
        // Print available commands
        print(commandsAsArray())
        
        // use ios_system to build
        ios_system("pdflatex --help") //--interaction=nonstopmode ~/myFile.tex"
        
    }

    
}



