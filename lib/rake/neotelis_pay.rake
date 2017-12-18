require 'fileutils'

namespace :neotelis_pay do
  namespace :init do
    desc "Generate neotelis_pay init file from example"
    task :create do
      source = File.join(Gem.loaded_specs["neotelis_pay"].full_gem_path, "neotelis_pay.rb")
      target = File.join(Rails.root, "config", "initializers", "neotelis_pay.rb")
      FileUtils.cp_r source, target
    end

  end
end