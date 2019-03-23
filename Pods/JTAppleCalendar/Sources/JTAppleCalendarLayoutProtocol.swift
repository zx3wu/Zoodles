//
//  JTAppleCalendarLayoutProtocol.swift
//  JTAppleCalendar
//
//  Created by JayT on 2016-10-02.
//
//


protocol JTAppleCalendarLayoutProtocol: class {
    var minimumInteritemSpacing: CGFloat {get set}
    var minimumLineSpacing: CGFloat {get set}
    var sectionInset: UIEdgeInsets {get set}
    var scrollDirection: UICollectionView.ScrollDirection {get set}
    func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint
}

extension UICollectionViewFlowLayout: JTAppleCalendarLayoutProtocol {}

