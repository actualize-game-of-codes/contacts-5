class Contact < ApplicationRecord
  def friendly_updated_at
    updated_at.strftime("%B %e, %Y")
  end
end
