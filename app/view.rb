module AutoLayoutAnimatedViewHelper

  def show(opts = {}, &block)
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
    opts = { animated: true }.merge(opts)
    self.hidden = false
    remove_all_constrains
    self.superview.addConstraints(shown_constraints)
    if opts[:animated]
      animate(opts) do |completed|
        block.call if block
      end
    else
      self.superview.layoutIfNeeded
      block.call if block
    end
  end

  def hide(opts = {}, &block)
    self.setTranslatesAutoresizingMaskIntoConstraints(false)
    opts = {
      animated: true,
      direction: :left
    }.merge(opts)
    remove_all_constrains
    self.superview.addConstraints(self.send("hidden_#{opts[:direction]}_constraints"))
    if opts[:animated]
      animate(opts) do |completed|
        # Make sure the view is completely hidden, just in case we have some
        # of scroll or menu going on.
        self.hidden = true
        block.call if block
      end
    else
      self.hidden = true
      self.superview.layoutIfNeeded
      block.call if block
    end
  end

  def animate(opts, &block)
    opts[:duration] ||= 0.3
    opts[:delay] ||= 0
    @active_animation_count ||= 0
    UIView.animateWithDuration(
      opts[:duration],
      delay: opts[:delay],
      options: UIViewAnimationOptionCurveEaseInOut|
        UIViewAnimationOptionBeginFromCurrentState,
      animations: lambda {
        @active_animation_count += 1
        self.superview.layoutIfNeeded
      },
      completion: lambda { |completed|
        @active_animation_count -= 1
        if @active_animation_count == 0
          block.call(completed)
        end
      }
    )
  end

  def remove_all_constrains
    self.superview.removeConstraints(all_constraints) if self.superview
  end

  def all_constraints
    [
      hidden_top_constraints,
      hidden_right_constraints,
      hidden_bottom_constraints,
      hidden_left_constraints,
      shown_constraints
    ].flatten
  end

  def hidden_bottom_constraints
    @hidden_bottom_constraint ||= [NSLayoutConstraint.constraintWithItem(self,
      attribute:NSLayoutAttributeTop,
      relatedBy:NSLayoutRelationEqual,
      toItem:self.superview,
      attribute:NSLayoutAttributeBottom,
      multiplier:1.0,
      constant:0.0)]
  end

  def hidden_top_constraints
    @hidden_top_constraints ||= [NSLayoutConstraint.constraintWithItem(self,
      attribute:NSLayoutAttributeBottom,
      relatedBy:NSLayoutRelationEqual,
      toItem:self.superview,
      attribute:NSLayoutAttributeTop,
      multiplier:1.0,
      constant:0.0)]
  end

  def hidden_right_constraints
    @hidden_right_constraints ||= [NSLayoutConstraint.constraintWithItem(self,
      attribute:NSLayoutAttributeLeft,
      relatedBy:NSLayoutRelationEqual,
      toItem:self.superview,
      attribute:NSLayoutAttributeRight,
      multiplier:1.0,
      constant:0.0)]
  end

  def hidden_left_constraints
    @hidden_left_constraints ||= [NSLayoutConstraint.constraintWithItem(self,
      attribute:NSLayoutAttributeRight,
      relatedBy:NSLayoutRelationEqual,
      toItem:self.superview,
      attribute:NSLayoutAttributeLeft,
      multiplier:1.0,
      constant:0.0)]
  end

  def shown_constraints
    @shown_constraints ||= [NSLayoutConstraint.constraintWithItem(self,
      attribute:NSLayoutAttributeLeft,
      relatedBy:NSLayoutRelationEqual,
      toItem:self.superview,
      attribute:NSLayoutAttributeLeft,
      multiplier:1.0,
      constant:0.0)]
  end

end

class UIView
 include AutoLayoutAnimatedViewHelper
end
