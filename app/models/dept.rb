class Dept < ActiveRecord::Base
  scope :projects, -> { where(project: true) }
  scope :departments, -> { where(project: false) }
end
