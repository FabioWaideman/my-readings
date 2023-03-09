require 'net/http'
require 'json'

class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def self.find(*args, &block)
    new(*args, &block).find
  end
end
