class PrivateTransitionContext

  attr_accessor :privateViewControllers,
                :containerView,
                :presentationStyle,
                :completionBlock,
                :animated,
                :interactive,
                :transitionWasCancelled

  def initialize(fromVC, toVC)
    self.presentationStyle = UIModalPresentationCustom
    self.containerView = fromVC.view.superview
    self.privateViewControllers = { fromVC:fromVC, toVC:toVC }
  end

  def initialFrameForViewController(viewController)
    self.containerView.bounds
  end

  def finalFrameForViewController(viewController)
    self.containerView.bounds
  end

  def viewControllerForKey(key)
    self.privateViewControllers[key]
  end

  def completeTransition(didComplete)
    self.completionBlock.call(didComplete) if self.completionBlock
  end
end
