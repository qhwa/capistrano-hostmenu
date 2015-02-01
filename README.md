# capistrano-hostmenu
A capistrano plugin which allows you to choose deploy host via a text menu.

Here's an example:

~~~
Please choose which server(s) to deploy:
  [1] triton-pub-01.cm10
  [2] triton-pub-02.cm10
  [3] all (default)
Please enter host_numbers (3):
~~~

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
