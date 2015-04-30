class Animator
  attr_accessor :direction

  def initialize(opts)
    self.direction = opts[:direction]
  end

  def transitionDuration(context)
    0.5
  end

  def animateTransition(context)
    if self.direction == :right
      toVC_x_start = -150
      fromVC_x_mid = -200
      toVC_x_mid = 100
    else
      toVC_x_start = 150
      fromVC_x_mid = 200
      toVC_x_mid = -100
    end

    toVC = context.viewControllerForKey(:toVC)
    fromVC = context.viewControllerForKey(:fromVC)
    context.containerView.insertSubview(toVC.view, belowSubview:fromVC.view)

    toVC.view.alpha = 0
    toVC.view.transform = CGAffineTransformTranslate(
      CGAffineTransformMakeScale(0.7, 0.7), toVC_x_start, 0)

    UIView.animateKeyframesWithDuration(self.transitionDuration(context),
      delay:0.0,
      options:0,
      animations: lambda {
        UIView.addKeyframeWithRelativeStartTime(0.0,
          relativeDuration:0.5,
          animations: lambda {
            fromVC.view.transform = CGAffineTransformConcat(
              CGAffineTransformMakeScale(0.9, 0.9),
              CGAffineTransformMakeTranslation(fromVC_x_mid, 0))
            fromVC.view.alpha = 0.5

            toVC.view.transform = CGAffineTransformConcat(
              CGAffineTransformMakeScale(0.9, 0.9),
              CGAffineTransformMakeTranslation(toVC_x_mid, 0))
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
