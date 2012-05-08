class ChildParent < ActiveRecord::Base
  belongs_to :parent, :class_name => :user
  belongs_to :child, :class_name => :user
end
