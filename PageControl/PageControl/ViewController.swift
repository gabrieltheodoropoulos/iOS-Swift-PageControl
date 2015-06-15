//
//  ViewController.swift
//  PageControl
//
//  Created by Gabriel Theodoropoulos on 15/6/15.
//  Copyright (c) 2015 Gabriel Theodoropoulos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!

    
    let totalPages = 5
    
    let sampleBGColors: Array<UIColor> = [UIColor.redColor(), UIColor.yellowColor(), UIColor.greenColor(), UIColor.magentaColor(), UIColor.orangeColor()]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        configureScrollView()
        configurePageControl()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    // MARK: Custom method implementation
    
    func configureScrollView() {
        // Enable paging.
        scrollView.pagingEnabled = true
        
        // Set the following flag values.
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        
        // Set the scrollview content size.
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * CGFloat(totalPages), scrollView.frame.size.height)
        
        // Set self as the delegate of the scrollview.
        scrollView.delegate = self
        
        // Load the TestView view from the TestView.xib file and configure it properly.
        for var i=0; i<totalPages; ++i {
            // Load the TestView view.
            let testView = NSBundle.mainBundle().loadNibNamed("TestView", owner: self, options: nil)[0] as! UIView
            
            // Set its frame and the background color.
            testView.frame = CGRectMake(CGFloat(i) * scrollView.frame.size.width, scrollView.frame.origin.y, scrollView.frame.size.width, scrollView.frame.size.height)
            testView.backgroundColor = sampleBGColors[i]
            
            // Set the proper message to the test view's label.
            let label = testView.viewWithTag(1) as! UILabel
            label.text = "Page #\(i + 1)"
            
            // Add the test view as a subview to the scrollview.
            scrollView.addSubview(testView)
        }
    }
    
    
    func configurePageControl() {
        // Set the total pages to the page control.
        pageControl.numberOfPages = totalPages
        
        // Set the initial page.
        pageControl.currentPage = 0
    }
    
    
    // MARK: UIScrollViewDelegate method implementation
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // Calculate the new page index depending on the content offset.
        let currentPage = floor(scrollView.contentOffset.x / UIScreen.mainScreen().bounds.size.width);
        
        // Set the new page index to the page control.
        pageControl.currentPage = Int(currentPage)
    }
    
    
    // MARK: IBAction method implementation
    
    @IBAction func changePage(sender: AnyObject) {
        // Calculate the frame that should scroll to based on the page control current page.
        var newFrame = scrollView.frame
        newFrame.origin.x = newFrame.size.width * CGFloat(pageControl.currentPage)
        scrollView.scrollRectToVisible(newFrame, animated: true)
        
    }
    
}

