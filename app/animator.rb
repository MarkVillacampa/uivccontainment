class Animator
  def transitionDuration(context)
    0.5
  end

  def animateTransition(context)
    toVC = context.viewControllerForKey(:toVC)
    fromVC = context.viewControllerForKey(:fromVC)
    context.containerView.insertSubview(toVC.view, belowSubview:fromVC.view)

    toVC.view.alpha = 0
    toVC.view.transform = CGAffineTransformTranslate(
      CGAffineTransformMakeScale(0.7, 0.7), -150, 0)


    UIView.animateKeyframesWithDuration(self.transitionDuration(context),
      delay:0.0,
      options:0,
      animations: lambda {
        UIView.addKeyframeWithRelativeStartTime(0.0,
          relativeDuration:0.5,
          animations: lambda {
            fromVC.view.transform = CGAffineTransformConcat(
              CGAffineTransformMakeScale(0.9, 0.9),
              CGAffineTransformMakeTranslation(-200, 0))
            fromVC.view.alpha = 0.5

            toVC.view.transform = CGAffineTransformConcat(
              CGAffineTransformMakeScale(0.9, 0.9),
              CGAffineTransformMakeTranslation(100, 0))
            toVC.view.alpha = 0.5
          })

        UIView.addKeyframeWithRelativeStartTime(0.5,
          relativeDuration:0.5,
          animations: lambda {
            fromVC.view.transform = CGAffineTransformMakeScale(0.5,0.5)
            fromVC.view.alpha = 0

            toVC.view.transform = CGAffineTransformIdentity
            toVC.view.alpha = 1
          })
      },
      completion: lambda { |finished|
        context.completeTransition(!context.transitionWasCancelled)
      })

  end
end
