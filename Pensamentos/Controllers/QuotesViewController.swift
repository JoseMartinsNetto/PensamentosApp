//
//  QuotesViewController.swift
//  Pensamentos
//
//  Created by Jose Martins on 30/10/20.
//

import UIKit

class QuotesViewController: UIViewController {
    @IBOutlet weak var imageViewPhoto: UIImageView!
    @IBOutlet weak var imageViewPhotoBg: UIImageView!
    @IBOutlet weak var labelQuote: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelTopConstraint: NSLayoutConstraint!
    
    let config = Configuration.instance
    
    let service = QuoteService.instance
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (notification) in
            self.formatView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        prepateQuote()
    }
    
    func formatView() {
        view.backgroundColor = config.colorScheme == 0 ? .white : UIColor(red: 156/255, green: 68/255, blue: 15/255, alpha: 1)
        
        labelQuote.textColor = config.colorScheme == 0 ? .black : .white
        labelAuthor.textColor = config.colorScheme == 0 ? UIColor(red: 192/255, green: 96/255, blue: 49/255, alpha: 1) : .yellow
        
        prepateQuote()
    }
    
    func prepateQuote() {
        timer?.invalidate()
        
        if config.autoRefresh {
            timer = Timer.scheduledTimer(withTimeInterval: config.timeInterval, repeats: true) { (timer) in
                self.showRandomQuote()
            }
        }
        
        
        showRandomQuote()
    }
    
    func showRandomQuote() {
        let quote = service.getRandomQuote()
        labelQuote.text = quote.quote
        labelAuthor.text = quote.author
        imageViewPhoto.image = UIImage(named: quote.image)
        imageViewPhotoBg.image = imageViewPhoto.image
        
        labelQuote.alpha = 0
        labelAuthor.alpha = 0
        imageViewPhoto.alpha = 0
        imageViewPhotoBg.alpha = 0
        labelTopConstraint.constant = 50
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.5) {
            self.labelQuote.alpha = 1
            self.labelAuthor.alpha = 1
            self.imageViewPhoto.alpha = 1
            self.imageViewPhotoBg.alpha = 0.25
            self.labelTopConstraint.constant = 10
            self.view.layoutIfNeeded()
            
        }
        
    }
    
}
