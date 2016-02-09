class Flow < ActiveRecord::Base
  belongs_to :request_application
  belongs_to :dept
  has_one :progress

  def first
    first_order = FlowOrder.order_list.first
    self.order = first_order.order
    self.dept_id = first_order.dept_id
  end
end
