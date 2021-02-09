class Cookie < ActiveRecord::Base
  require 'byebug'

  belongs_to :storage, polymorphic: :true
  
  validates :storage, presence: true
  validates :batch_number, presence: true

  def ready?(cookie)
    if(cookie.pickup_time >= Time.now) 
      return false
    end
    true
  end

  def time_left(cookie)
    time = cookie.pickup_time - Time.now
    if(time < 1 )
      return "Cookie is ready for pickup"
    end
    return (time/60).round()
  end

end
