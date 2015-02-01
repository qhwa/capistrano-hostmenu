module Hostmenu
  class Menu

    include Capistrano::DSL

    def self.set_default_config
      set :host_menu_prompt_msg,                '请选择你要操作的服务器(输入括号的数字)'.blue
      set :host_menu_default_selection,         :all # or :first, 1
      set :host_menu_caption_of_default,        '(默认)'
      set :host_menu_invalid_range_msg,         "输入错误, 只能输入 (1..%d)".red
      set :host_menu_invalid_multi_choose_msg,  "输入错误，只能选择部分或者全部".red
    end

    def initialize
      if deploy_hosts.size > 1
        prompt_menu default: fetch(:host_menu_default_selection)
      end
    end

    def prompt_menu default: :all
      puts fetch(:host_menu_prompt_msg)

      default     = input_for(default)
      default_cap = fetch(:host_menu_caption_of_default)

      (deploy_hosts + [all_caption]).each_with_index do |host, i|
        cap = if i == default - 1
                "[%d] %s %s" % [i+1, host, default_cap]
              else
                "[%d] %s" % [i+1, host]
              end
        puts "  " << cap.green
      end

      ask :host_numbers, default.to_s
      set_hosts
    end

    def input_for selection
      case selection
      when :all
        max_selection
      when 0
        1
      when Fixnum
        selection
      else
        1
      end
    end

    def max_selection
      deploy_hosts.size + 1
    end

    def deploy_hosts
      release_roles(:all)
    end

    def all_caption
      '全部'
    end

    def selection_for_all
      max_selection
    end

    def set_hosts
      ids = fetch(:host_numbers).split(/\s*,\s*/).map(&:to_i).uniq
      unless ids.all? {|i| (1..max_selection).include? i}
        puts fetch(:host_menu_invalid_range_msg) % max_selection
        exit 1
      end

      if ids.size > 1 && ids.include?(selection_for_all)
        puts fetch(:host_menu_invalid_multi_choose_msg)
        exit 1
      end

      unless ids.include?(selection_for_all)
        set_host_filter ids.map {|i| deploy_hosts[i-1].hostname}
      end
    end

    def set_host_filter hosts
      if defined? Capistrano::Configuration::Servers::HostFilter
        set :filter, hosts: hosts
      else
        # hack for Capistrano v3.3+
        Capistrano::Configuration.env.send(:servers).send(:servers).select! do |srv|
          hosts.include?(srv.hostname)
        end
      end
    end
  end
end
