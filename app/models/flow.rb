class Flow < ActiveRecord::Base
  belongs_to :request_application
  belongs_to :dept
  has_one :progress, dependent: :destroy

  # 初期フローを作成する。
  def init_flow
    first_order = FlowOrder.order_list.first
    self.order = first_order.order
    self.dept_id = first_order.dept_id
  end

  # 進捗を進める
  def proceed
    # 進捗状況が紐付いていない時は、新たな進捗情報を作成する
    if progress.nil?
      progress = Progress.new
      progress.flow_id = id
      progress.in_date = Time.current
      progress.save
    else
      progress = self.progress
      progress.out_date = Time.current
      progress.save
      # 次のフローも合わせて生成。最後の時はcloseする。
      next_flow if FlowOrder.maximum('order') > order
      RequestApplication.closed(request_application_id) if FlowOrder.maximum('order') == order
    end
  end

  # 進捗を戻す
  def retreat
  end

  private

  # 次のフローへ進む
  def next_flow
    flow = Flow.new
    flow.request_application_id = request_application_id
    flow.order = order + 1
    flow.dept_id = if FlowOrder.find_by(order: flow.order).project_flg
                     RequestApplication.find(request_application_id).project_id
                   else
                     FlowOrder.find_by(order: flow.order).dept_id
                   end
    flow.save
  end

  # 前のフローに戻る
  def back_flow
    flow = Flow.new
    flow.request_application_id = request_application_id
    flow.order = order + 1
    flow.dept_id = if FlowOrder.find_by(order: flow.order).project_flg
                     RequestApplication.find(request_application_id).project_id
                   else
                     FlowOrder.find_by(order: flow.order).dept_id
                   end
    flow.save
  end
end
