//
//  BaseController.swift
//  Medyear
//
//  Created by Bahrom Abdullayev on 12/7/14.
//  Copyright (c) 2014 Personiform. All rights reserved.
//

import UIKit
//import PKHUD




class BaseController: UIViewController, SlideNavigationControllerDelegate {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        hasRightMenu = false
        hasLeftMenu = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate var _menuBarButton: UIBarButtonItem!
    var menuBarButton: UIBarButtonItem{
        
        get{
            if _menuBarButton == nil{
                _menuBarButton = UIBarButtonItem(image: UIImage(named: "hamburger")?.withRenderingMode(.alwaysTemplate), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseController.menuButtonAction(_:)))
                _menuBarButton.tintColor = UIColor.white
            }
            return _menuBarButton
        }
    }
    
    fileprivate var _backBarButton: UIBarButtonItem!
    var backBarButton: UIBarButtonItem{
        
        get{
            if _backBarButton == nil{
                _backBarButton = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseController.backButtonAction(_:)))
                _backBarButton.tintColor = UIColor.white
            }
            return _backBarButton
        }
    }
    
    fileprivate var _userBarButton: UIBarButtonItem!
    var userBarButton: UIBarButtonItem{
        get{
            if _userBarButton == nil{
                _userBarButton = UIBarButtonItem(image: UIImage(named: "profile")?.withRenderingMode(.alwaysTemplate), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BaseController.userButtonAction(_:)))
            }
            return _userBarButton
        }
    }

    
    func backButtonAction(_ sender: UIButton!){
        self.navigationController!.popViewController(animated:true)
    }
    
    func menuButtonAction(_ sender: UIButton!){
        //SlideNavigationController.sharedInstance().toggleLeftMenu()
    }
    
    func userButtonAction(_ sender: UIButton!){
        
    }
    
   
    
    func statusBarStyle() -> UIStatusBarStyle{
        
        return .lightContent
    }
    
    func animation(_ point: Float, progress: Float) {
        var frame: CGRect!
        let top: CGFloat = 7
        if point == 0 {
            frame = self.view.bounds
        }else{
            frame = self.view.frame
            frame.origin.y = top
            frame.origin.x = top
            frame.size.width = self.view.frame.size.width - 2*top
            frame.size.height = self.view.frame.size.height - 2*top
        }
        UIView.animate(withDuration:0.4, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
                self.view.frame = frame
            }) { (finished) -> Void in
                
        }
    }
    
    func slideNavigationControllerShouldDisplayLeftMenu() -> Bool {
        return hasLeftMenu
    }

    func slideNavigationControllerShouldDisplayRightMenu() -> Bool {
        return hasRightMenu
    }
}
