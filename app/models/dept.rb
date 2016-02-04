class Dept < ActiveRecord::Base
    scope :projects, -> {where(project: true)}
    scope :department, -> {where(project: false)}
end
