class Sighting < ApplicationRecord
  belongs_to :bird
  belongs_to :location
end

# EXPLAINED: using references in 'rails g' command will add relationships automatically to the generated model 