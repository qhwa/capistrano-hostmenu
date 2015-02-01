# capistrano-hostmenu
A capistrano plugin which allows you to choose deploy host via a text menu.

Here's an example:

~~~
Please choose which server(s) to deploy:
  [1] example1.com
  [2] example2.com
  [3] all (default)
Please enter host_numbers (3):
~~~

## Installation

~~~sh
gem install capistrano-hostmenu
~~~

or put this in your `Gemfile` then run `bundle install`:

~~~ruby
gem 'capistrano-hostmenu'
~~~

After the gem is installed, put this in your `Capfile`:

~~~ruby
require 'capistrano/hostmenu'
~~~

Then you will see host selecting menu any time before deploying.

## Configurations

set these variables in your deploy config (commonly `deploy.rb`)

~~~ruby
set :host_menu_prompt_msg,                'Please choose which server(s) to deploy:'.blue
set :host_menu_default_selection,         :all # or :first, 1
set :host_menu_caption_of_all,            'all'
set :host_menu_caption_of_default,        '(default)'
set :host_menu_invalid_range_msg,         'Please provide a number in (1..%d)'.red
set :host_menu_invalid_multi_choose_msg,  'Do you mean to choose all servers?'.red
~~~
