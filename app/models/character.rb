class Character < ActiveRecord::Base

  before_create do
    self.name = self.name.downcase
  end

end
