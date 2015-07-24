namespace :deploy do

  desc 'print environment variables'
  task :info do
    puts "--" * 50
    puts "About to deploy, check your seatbelt~"
    puts "env:    #{fetch(:rails_env).to_s.bold.blue}"
    puts "branch: #{fetch(:branch).to_s.bold.green}"
    puts "server: #{roles(:all).map(&:hostname).join("\n        ").red}"
    puts "--" * 50
  end

  desc <<-DESC
        Prompt a text based list menu for user to select. \
        Following changes will only be applied on selected servers.

        User will see menu like this:

        ~~~
        Please select target host(s):
          [1] my.example1.com
          [2] my.example2.com
          [3] all (default)
        Please enter host_numbers (3):
        ~~~
    DESC
  task :host_menu do
    next if fetch(:show_host_menu) == false

    Capistrano::Hostmenu.new
    invoke 'deploy:info' unless fetch(:host_menu_show_info_after_select) == false
  end
end


Capistrano::Hostmenu.set_default_config

Capistrano::DSL.stages.each do |stage|
  after stage, 'deploy:host_menu'
end
