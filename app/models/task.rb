class Task < ApplicationRecord
    validates :name, :retail, presence: true
end
