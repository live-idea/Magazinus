class Shopmailer < ActionMailer::Base
  def new_good (category, good)
     recipients "obondar@gmail.com"
     from       "system@example.com"
     subject    "New good added"
     body[:category] = category
     body[:good] = good
  end

end
