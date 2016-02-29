class RequestApplication < ActiveRecord::Base
  has_many :flows, dependent: :destroy
  belongs_to :project, class_name: "Dept"
  mount_uploader :filename, FileUploader

  validates :management_no, uniqueness: true, presence: true

  def self.closed(id)
    request_application = RequestApplication.find(id)
    request_application.close = true
    request_application.save
  end


  # 通常closeかどうか
  def normal_closed?
    self.close? && self.flows.order(:history_no).last.order == FlowOrder.maximum(:order)
  end

  # 中断closeかどうか
  def interrupt_closeed?
    self.close? && self.flows.order(:history_no).last.order != FlowOrder.maximum(:order)
  end


  def close_status
    ("済" if normal_closed? )|| ("中断" if interrupt_closeed? )
  end

  def interrupt_permit?
  #書記状態ではなくが、フローの一番最初の部署に処理がある状態のとき
   ! initial? &&  self.flows.order(:history_no).last.order == 1
  end

  def delete_permit?
    initial?
  end


  private

    def initial?
      self.flows.order(:order).last.history_no == 1
    end


end
