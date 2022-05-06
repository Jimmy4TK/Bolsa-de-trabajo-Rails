class Company < ApplicationRecord
    #Relations
    has_many :work_notifications, dependent: :destroy

    #Validations
    validates :name, presence: true
    validates :token, uniqueness: true

    #Callbacks
    before_create :set_token


    def set_token
        self.token = SecureRandom.uuid
    end
    
end
