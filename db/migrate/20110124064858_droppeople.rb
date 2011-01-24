class Droppeople < ActiveRecord::Migration
  def self.up
    drop_table :people
  end

  def self.down
  end
end
