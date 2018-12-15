# GhostSlider
仿照 微信读书进度条



version 0.1



GhostSlider: UISlider



只要调用

```swift
public func markOriginValue(_ value: Float)
```

就可以把设置幽灵 thumb，他会以阴影的方式，显示在你想要他出现的位置，并且大小和你的 Thumb 一样



需要接收点击事件，请给 GhostSlider 的实例添加

```swift
let silder = GhostSlider()
slider.addTarget(self, selector: #selector(didPressGhostSlider:), event: .touchUpInside)
```

其他使用方法和 UISlider 一致



