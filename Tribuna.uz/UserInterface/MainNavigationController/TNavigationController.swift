


import UIKit

class TNavigationController: UINavigationController, SlideMenuControllerDelegate {
    
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    override init(rootViewController: UIViewController){
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.changeNavigationBarBackColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func changeNavigationBarBackColor(){
        self.navigationBar.isTranslucent = false
        if (!SYSTEM_VERSION_LESS_THAN(version: "5.0")) {
            self.navigationBar.setBackgroundImage(UIImage.getImageWithColor(UIColor.mainNavBackColor(), withSize: CGSize(width:1, height:1)).stretchableImage(withLeftCapWidth: 0, topCapHeight: 0), for: UIBarMetrics.default)
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
    
        return .lightContent
    }
}
