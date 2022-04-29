class Company < ApplicationRecord
    has_many :work_notifications, dependent: :destroy
end
