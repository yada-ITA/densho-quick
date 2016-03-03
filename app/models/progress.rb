class Progress < ActiveRecord::Base
  belongs_to :flow

  # 新たな進捗情報を作成する。
  def self.new_flow(flow_id)
    progress = Progress.new
    progress.flow_id = flow_id
    progress.in_date = Time.current
    progress.save
  end

  # 進捗完了とする （終了日時をセットする)
  def finished
    self.out_date = Time.current
    save
  end
end
