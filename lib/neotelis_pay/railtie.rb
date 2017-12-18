module NeotelisPay
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'rake/neotelis_pay.rake'
    end
  end
end