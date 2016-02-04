class Flow < ActiveRecord::Base
  belongs_to :request_application
  belongs_to :dept
end
