require 'yaml'
class Config
  attr_accessor :config

  def initialize()
    @config = YAML.load(File.read("config.yml"))
  end

  def url
    @config['url']
  end

  def browser
    @config['browser']
  end

  def delay_open_document
    @config['delay_open_document']
  end
end
