Kaminari.configure do |config|
  config.default_per_page      = 12# 25 by default
  config.max_per_page          # nil by default
  config.max_pages             # nil by default
  config.window                # 4 by default
  config.outer_window          # 0 by default
  config.left                  # 0 by default
  config.right                 # 0 by default
  config.page_method_name      # :page by default
  config.param_name            # :page by default
  config.params_on_first_page  # false by default
end