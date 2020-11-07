class User < ActiveRecord::Base

  def self.valid_entry?(parameters)
    reg = /(^[a-zA-z0-9_@]+$)/
    valid = true

    parameters.each do |key,entry|
      if entry.blank? || !(entry =~ reg) || (entry.ord % 32) == 0
        valid = false
      end
    end
    return valid
  end
end
