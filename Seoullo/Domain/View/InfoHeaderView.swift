//
//  InfoHeaderView.swift
//  Seoullo
//
//  Created by 박현준 on 2023/05/25.
//

import UIKit
import SnapKit

protocol InfoHeaderViewDelegate: AnyObject {
    func bannerTouched(_ int: Int)
}

class InfoHeaderView: UIView {

//MARK: - Properties
    
    let imageArray: [UIImage] = [UIImage(named: "banner01")!, UIImage(named: "banner02")!, UIImage(named: "banner03")!]
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 400)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        // 스크롤되는 이미지를 정중앙으로 배치
        cv.isPagingEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.decelerationRate = .fast
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        $0.numberOfPages = imageArray.count
        $0.currentPage = 0
        $0.pageIndicatorTintColor = UIColor.seoulloGray
        $0.currentPageIndicatorTintColor = UIColor.seoulloOrange
        return $0
    }(UIPageControl())
        
    
    weak var delegate: InfoHeaderViewDelegate?
    
//MARK: - Life cycles
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
            setUIandConstraints()
            collectionView.delegate = self
            collectionView.dataSource = self
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    
//MARK: - set UI
    func setUIandConstraints() {
        addSubview(collectionView)
        addSubview(pageControl)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top).inset(2)
        }
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
        }
    }
    
}
 
//MARK: - InfoHeaderView CollectionView Delegate, DataSource
extension InfoHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell() }
        let image = imageArray[indexPath.row]
        cell.configure(image: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        // 셀의 너비와 라인 간격을 포함한 값 계산
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        // 스크롤뷰의 현재 컨텐트 오프셋을 기반으로 예상된 인덱스 계산
        let estimatedIndex = scrollView.contentOffset.x / cellWidthIncludingSpacing
        
        // 목표 컨텐트 오프셋을 결정하기 위한 인덱스 값을 설정
        let index: Int
        if velocity.x > 0 {
            // 오른쪽으로 스크롤하는 경우, 예상된 인덱스를 올림해 다음 셀 이동
            index = Int(ceil(estimatedIndex))
        } else if velocity.x < 0 {
            // 왼쪽으로 스크롤하는 경우, 예상된 인덱스를 내림해 이전 셀 이동
            index = Int(floor(estimatedIndex))
        } else {
            // 가로 스크롤이 멈춘 경우, 예상된 인덱스를 반올림해 가장 가까운 셀로 이동
            index = Int(round(estimatedIndex))
        }
        
        // 목표 컨텐트 오프셋을 설정하여 애니메이션이 이동할 위치를 결정
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidthIncludingSpacing, y: 0)
        // 페이지 컨트롤의 현재 페이지를 설정합니다.
        pageControl.currentPage = index
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bannerTouched(indexPath.row)
    }
}
