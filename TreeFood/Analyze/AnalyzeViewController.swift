//
//  AnalyzeViewController.swift
//  TreeFood
//
//  Created by 王韬 on 2021/10/19.
//

import UIKit

class AnalyzeViewController: UIViewController {
    // MARK: - 私有属性

    var leftFlag = true
    var rightFlag = false
    var index = 1
    var currentIndex: Int = 0

    let leftView = AnalyzeFirstViewController(), rightView = AnalyzeSecondViewController()
    let viewControllers = [AnalyzeFirstViewController(), AnalyzeSecondViewController()]

    lazy var topImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "apple")
        return image
    }()

    lazy var pageControl: UIPageControl = {
        let page = UIPageControl()
        page.backgroundColor = .clear
        page.numberOfPages = viewControllers.count
        page.currentPage = 0
        page.isEnabled = false
        page.currentPageIndicatorTintColor = UIColor(r: 245, g: 146, b: 104)
        page.pageIndicatorTintColor = UIColor(r: 224, g: 224, b: 224)
        return page
    }()

    lazy var pageViewController: UIPageViewController = {
        let pageVc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVc.dataSource = self
        pageVc.delegate = self
        pageVc.setViewControllers([leftView], direction: .forward, animated: false, completion: nil)
        return pageVc
    }()

    //MARK: -公有方法
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    //MARK: -私有方法
    
    private func configUI() {
        
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.97, alpha: 1)
        
        navigation.bar.isShadowHidden = true
        navigation.bar.alpha = 0
    }
}

extension AnalyzeViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        pageControl.currentPage = 0
        if currentIndex - 1 >= 0 {
            currentIndex -= 1
            return leftView
        }
        return nil
    }

    func presentationCount(for: UIPageViewController) -> Int {
        return 1
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        pageControl.currentPage = 1
        if rightFlag {
            return nil
        }
        leftFlag = false
        rightFlag = true

        return rightView
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed && finished {
            index += 1
        }
    }
}
