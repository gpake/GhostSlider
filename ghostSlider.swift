//
//  GhostSlider.swift
//  GhostSlider
//
//  Created by Ashbringer on 2018/11/26.
//  Copyright © 2018 Ashbringer. All rights reserved.
//

class GhostSlider: UISlider {
    // MARK: - Const
    
    // MARK: - Properties
    /// the origin value, tap ghost to jump back here
    public var originValue: Float = 0.0
    
    // MARK: - Views
    /// Slider Thumb
    public private(set) var thumb: UIImageView?
    /// Ghost thumb for showing origin value as a dot
    public private(set) lazy var ghostThumb: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lookupThumb()
        sendSubviewToBack(ghostThumb)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let isTouchingThumb = touchingThumb(touches, with: event)
        if isTouchingThumb {
            return
        }
        let isTouchingGhost = touchingGhost(touches, with: event)
        if isTouchingGhost {
            // trigger
            value = self.originValue
            // set value dose not trigger action, have to do it manual
            sendActions(for: .valueChanged)
        }
        super.touchesEnded(touches, with: event)
    }
    
    private func touchingThumb(_ touches: Set<UITouch>, with event: UIEvent?) -> Bool {
        
        let touch = touches.first
        let point = touch?.location(in: self.thumb) ?? .zero
        let inside = self.thumb?.point(inside: point, with: event) ?? false
        return inside
    }
    
    private func touchingGhost(_ touches: Set<UITouch>, with event: UIEvent?) -> Bool {
        let touch = touches.first
        let point = touch?.location(in: self.ghostThumb) ?? .zero
        let inside = self.ghostThumb.point(inside: point, with: event)
        return inside
    }
    
    // MARK: - View inits
    private func makeViews() {
        addSubview(ghostThumb)
    }
    
    // MARK: - Public Actions
    public func markOriginValue(_ value: Float) {
        self.value = value
        originValue = value
        
        let thumbFrame = self.thumb?.frame ?? .zero
//        ghostThumb.frame = UIEdgeInsetsInsetRect(thumbFrame, UIEdgeInsets(top: 1, left: 2, bottom: 2, right: 2))
        ghostThumb.frame = thumbFrame.inset(by: UIEdgeInsets(top: 1, left: 2, bottom: 2, right: 2)) // swift 4.2
        ghostThumb.layer.cornerRadius = ghostThumb.frame.width / 2
    }
    
    // MARK: - Internal Actions
    private func lookupThumb() {
        if self.thumb == nil {
            for case let view as UIImageView in subviews {
                if view.frame.height > 2 // should taller than tracker
                    && view.frame.width == view.frame.height {
                    self.thumb = view
                    break
                }
            }
        }
    }
}