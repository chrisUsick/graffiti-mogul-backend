class Tag < ApplicationRecord
  def as_json(options={})
    obj = super(options)
    obj[:lonlat] = {
      lon: self.location.x,
      lat: self.location.y
    }
    obj.delete "location"
    obj
  end
end
