class RequestApplication < ActiveRecord::Base
  has_many :flows, dependent: :destroy
  belongs_to :project, class_name: "Dept"

  def self.closed(id)
    request_application = RequestApplication.find(id)
    request_application.close = true
    request_application.save
  end
end
