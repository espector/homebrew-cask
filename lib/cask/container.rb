class Cask::Container; end

require 'cask/container/base'
require 'cask/container/air'
require 'cask/container/bzip2'
require 'cask/container/cab'
require 'cask/container/criteria'
require 'cask/container/dmg'
require 'cask/container/generic_unar'
require 'cask/container/gzip'
require 'cask/container/naked'
require 'cask/container/sevenzip'
require 'cask/container/sit'
require 'cask/container/tar'
require 'cask/container/rar'
require 'cask/container/zip'

class Cask::Container
  def self.containers
    [
      Cask::Container::Air,
      Cask::Container::Cab,
      Cask::Container::Dmg,
      Cask::Container::SevenZip,
      Cask::Container::Sit,
      Cask::Container::Tar,
      Cask::Container::Rar,
      Cask::Container::Zip,
      Cask::Container::Bzip2,
      Cask::Container::Gzip,    # pure gzip, not tar/gzip
      Cask::Container::Naked,
    ]
  end

  def self.for_path(path, command)
    odebug "Determining which containers to use based on filetype"
    criteria = Cask::Container::Criteria.new(path, command)
    containers.find do |c|
      odebug "Checking container class #{c}"
      c.me?(criteria)
    end
  end

  def self.from_type(type)
    odebug "Determining which containers to use based on 'container_type'"
    containers.find do |c|
      odebug "Checking container class #{c}"
      c.to_s == "Cask::Container::#{type.to_s.split('_').map(&:capitalize).join}"
    end
  end
end
