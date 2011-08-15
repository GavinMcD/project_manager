class Person < ActiveRecord::Base
  
  has_many  :roles
  has_many  :projects, :through => :roles     # middle table must define belongs to on both of these
  
  validates :first_name, :presence => true    # rails validations - look up
  validates :last_name,  :presence => true
  
  before_save :cleanup
  
  scope :all_lazy, select('*').order("first_name ASC")
  scope :find_lazy, lambda {|id| where(primary_key => id) }
  scope :all_ordered_last, all_lazy.order("last_name ASC")
  
  def name
    "#{first_name} #{last_name}"
  end
  
  private
  
  def cleanup
    self[:first_name] = self[:first_name].capitalize
  end
  
end
