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
    close? && flows.order(:history_no).last.order == FlowOrder.maximum(:order)
  end

  # 中断closeかどうか
  def interrupt_closeed?
    close? && flows.order(:history_no).last.order != FlowOrder.maximum(:order)
  end

  # フローの状況をみて通常close or 中断closeを確認後、結果を返す
  def close_status
    ("済" if normal_closed?) || ("中断" if interrupt_closeed?)
  end

  # 中断できるフローの状態かどうか。
  def interrupt_permit?
    # 初期状態ではなく、かつ要求書処理が終了していないときに、フローの一番最初の部署に最新処理がある状態。
    !initial? && !close? && flows.order(:history_no).last.order == 1
  end

  def delete_permit?
    initial?
  end

  # 中断closeする
  def interrupt
    # closeは同じ。中断か正常かは、フローの履歴状況で判断する
    self.close = true
    save
    # TODO: 時刻もセットする。
  end

  # 中断しているかどうか
  def interrunpt?
    # 要求書がcloseしていて、かつフローの一番最初の部署に最後の処理がある状態が中断している状態。
    close? && flows.order(:history_no).last.order == 1
  end

  private

  def initial?
    flows.order(:order).last.history_no == 1
  end
end
