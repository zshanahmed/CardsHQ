class User < ActiveRecord::Base

  def self.valid_entry?(parameters)
    reg = /(^[a-zA-z0-9_]+$)/

    blank = parameters[:username].eql?("") || parameters[:password].eql?("") || parameters[:email].eql?("")
    good_format = parameters[:username] =~ reg || parameters[:email] =~ reg  || parameters[:password] =~ reg
    if ! blank
      spaces = (parameters[:username].ord % 32) + (parameters[:email].ord % 32) + (parameters[:password].ord % 32)
      spaces_only = spaces == 0
    else
      spaces_only = true
    end
    return !spaces_only || !good_format || blank

  end
end
