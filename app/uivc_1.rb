class VCOne < UIViewController

  # Lifecycle

  def loadView
    super
    square = UIView.alloc.initWithFrame(self.view.bounds)
    square.autoresizingMask = UIViewAutoresizingFlexibleWidth |
      UIViewAutoresizingFlexibleHeight
    square.backgroundColor = UIColor.redColor
    self.view.addSubview(square)
  end

  def viewDidLoad
  end

  def viewWillAppear(animated)
  end

  def viewDidAppear(animated)
  end

  def viewWillDisappear(animated)
  end

  def viewDidDisappear(animated)
  end

  def viewWillLayoutSubviews
  end

  def viewDidLayoutSubviews
  end

  # Rotation

  # def shouldAutoRotate
  # end

  # def supportedInterfaceOrientations
  # end

  # def preferredInterfaceOrientationForPresentation
  # end

  # Child VC

  def willMoveToParentViewController(controller)
  end

  def didMoveToParentViewController(controller)
  end


end
