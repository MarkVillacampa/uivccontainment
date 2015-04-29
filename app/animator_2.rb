# class Animator
#   def transitionDuration(transitionContext)
#     1
#   end

#   def animateTransition(transitionContext)
#     toViewController = transitionContext.viewControllerForKey(:UITransitionContextToViewControllerKey)
#     fromViewController = transitionContext.viewControllerForKey(:UITransitionContextFromViewControllerKey)
#     transitionContext.containerView.insertSubview(toViewController.view, belowSubview:fromViewController.view)

#     toViewController.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 320, 0)


#     UIView.animateKeyframesWithDuration(self.transitionDuration(transitionContext),
#       delay:0.0,
#       options:0,
#       animations: lambda {
#         UIView.addKeyframeWithRelativeStartTime(0.0,
#           relativeDuration:1,
#           animations: lambda {
#             fromViewController.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -320, 0)

#             toViewController.view.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)
#           })
#       },
#       completion: lambda { |finished|
#         p "animation finished"
#         transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
#       })

#   end

#   # def animationEnded(transitionCompleted)
#   #   p "animationEnded"
#   #   p "Canceled! #{transitionCompleted}"
#   #   if !transitionCompleted
#   #     fromViewController.view.transform = CGAffineTransformIdentity
#   #     toViewController.view.removeFromSuperview
#   #     toViewController.removeFromParentViewController
#   #   end
#   # end
# end
