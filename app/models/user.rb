class User < ApplicationRecord

  # validations
  validates_presence_of :username, :name#, :message => "no puede quedar en blanco."

end
