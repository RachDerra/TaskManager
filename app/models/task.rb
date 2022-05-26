class Task < ApplicationRecord
    validates :name, :retail, presence: true
    enum status: { notstarted:1,inprogress:2,completed:3 }
    enum priority: { high:1,medium:2,low:3 }
    scope :search_name, -> name {where("name LIKE ?", "%#{name}%")}
    scope :search_status, -> status {where(status: status)}
    paginates_per 3   

    def badge_color
        case status
        when 'notstarted'   
            'secondary'
        when 'inprogress'  
            'info'
        when 'completed'
            'success'
        end   
    end
end
