class Author < ActiveRecord::Base
  has_many :versions
  
  def to_param
    name
  end
  def self.find_or_create(name, ip)
    find_by_name_and_ip(name, ip) || create(:name => name, :ip => ip)
  end
end
