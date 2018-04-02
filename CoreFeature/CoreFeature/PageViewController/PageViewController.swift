//
//  PageViewController.swift
//  CoreFeature
//
//  Created by Mollick, Md Razib Uddin on 3/30/18.
//  Copyright © 2018 Ashley Furniture. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    var pageViewController: UIPageViewController!
    let pages = ["DomesticPageViewController", "SafariPageViewController", ]
    
    // Page View Controller Datasource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let index = pages.index(of: viewController.restorationIdentifier!) {
            if index > 0 {
                return viewControllerAtIndex(index - 1)
            }
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let index = pages.index(of: viewController.restorationIdentifier!) {
            if index < pages.count - 1 {
                return viewControllerAtIndex(index + 1)
            }
        }
        
        return nil
    }
    
    
    func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        let storyboard = UIStoryboard(name: "page", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DomesticPageViewControllerID")
        return vc
        
    }
    
    var pageControl = UIPageControl()
    
    func setupPageControl() {

        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = 2
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.lightGray
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.backgroundColor = UIColor.clear
        self.view.addSubview(pageControl)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let storyboard = UIStoryboard(name: "page", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "page_id") 
        
            self.addChildViewController(vc)
            self.view.addSubview(vc.view)
            
            pageViewController = vc as! UIPageViewController
            pageViewController.dataSource = self
            pageViewController.delegate = self
            
            pageViewController.setViewControllers([viewControllerAtIndex(0)!], direction: .forward, animated: true, completion: nil)
            pageViewController.didMove(toParentViewController: self)
            
            
        setupPageControl()
        
    }
    
    private func setupPageControl1() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.lightGray
        appearance.currentPageIndicatorTintColor = UIColor.black
        appearance.backgroundColor = UIColor.clear
        
        
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        //setupPageControl()
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
