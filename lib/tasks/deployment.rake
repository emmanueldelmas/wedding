# coding: utf-8

namespace :application do
  desc "Install the application"
  
  APPLICATION_FILES = [
    ".ruby-version", ".ruby-gemset", "app", "config", "config.ru", "db", "Gemfile", "Gemfile.lock",
    "lib", "log", "public", "Rakefile", "spec", "tmp", "vendor/assets"
  ]
  
  task :install do
    puts "run bundle install --deployment"
    Bundler.with_clean_env do
      sh "bundle install --deployment"
    end

    # copie les fichiers de configuration
    mkdir_p("#{Rails.root}/tmp")
    
    sleep 4

    # thin files permissions
    Rake::Task['application:set_appli_acl'].invoke
    
    sleep 4
    puts "run db:migrate"
    Rake::Task['db:migrate'].invoke

    # thin files permissions
    Rake::Task['application:set_appli_acl'].invoke    
  end
  
  desc "Get the last version of the application"
  task :update => :environment do
    puts "run bundle install --deployment"
    Bundler.with_clean_env do
      sh "bundle install --deployment"
    end

    puts "run db:migrate"
    Rake::Task['db:migrate'].invoke

    abcs = ActiveRecord::Base.configurations
    ActiveRecord::Base.establish_connection( abcs[Rails.env])

    #### precompile assets
    Rake::Task['assets:precompile'].invoke    
    
    # mongrel files permissions
    Rake::Task['application:set_appli_acl'].invoke
    
    # # restart application
    application_name = File.basename( File.expand_path( Rails.root))
    system "thiny restart #{application_name}"
  end
  
  desc "Change thin files ACL, must be root (sudo)"
  task :set_appli_acl do    
    # mongrel files permissions
    system "chown -R www-data:www-data " + APPLICATION_FILES.collect{ |p| "#{Rails.root}/#{p}"}.join( " ")
    system "chmod -R u=rwx,g=rwX,o= " + APPLICATION_FILES.collect{ |p| "#{Rails.root}/#{p}"}.join( " ")
  end
end