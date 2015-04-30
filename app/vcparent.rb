class VCParent < UIViewController
  attr_accessor :viewControllers

  def viewDidLoad
    super
    @vc_one = VCOne.alloc.init
    self.addChildViewController(@vc_one)
    self.view.addSubview(@vc_one.view)
    @vc_one.didMoveToParentViewController(self)

    @vc_two = VCTwo.alloc.init

    self.viewControllers = [@vc_one, @vc_two]

    @segment = UISegmentedControl.alloc.initWithItems(["Ahora", "Reserva"])
    @segment.frame = @segment.frame.tap do |f|
      f.origin.x = 20
      f.origin.y = 40
    end
    @segment.selectedSegmentIndex = 0
    @segment.addTarget(self, action: "switch_view_controller:",
      forControlEvents:UIControlEventValueChanged)
    self.view.addSubview(@segment)
  end

  def switch_view_controller(segment)
    @segment.userInteractionEnabled = false

    case segment.selectedSegmentIndex
      when 0
        move_to_view_controller(@vc_one)
      when 1
        move_to_view_controller(@vc_two)
    end
  end

  def move_to_view_controller(toVC)
    fromVC = self.childViewControllers.first
    fromVC.willMoveToParentViewController(nil)
    self.addChildViewController(toVC)


    index_from = self.viewControllers.index(fromVC)
    index_to = self.viewControllers.index(toVC)
    animator = Animator.new(direction: index_from > index_to ? :left : :right)
    context = PrivateTransitionContext.new(fromVC, toVC)

    context.animated = true
    context.interactive = false
    context.completionBlock = lambda { |didComplete|
      if didComplete
        fromVC.view.removeFromSuperview
        fromVC.removeFromParentViewController
        toVC.didMoveToParentViewController(self)
      end
      @segment.userInteractionEnabled = true
    }

    animator.animateTransition(context)
  end

end
