Rake::Task['db:reset'].clear

namespace :db do
  task :reset do
    ENV['VERSION'] = '0'
    Rake::Task['db:migrate'].invoke
    ENV.delete('VERSION')
    Rake::Task['db:migrate'].reenable
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed_fu'].invoke
  end
end
