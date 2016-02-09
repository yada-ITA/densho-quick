class RequestApplication < ActiveRecord::Base
  has_many :flows
  belongs_to :project, class_name: "Dept"
end
