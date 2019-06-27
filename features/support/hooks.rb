# frozen_string_literal: true

# Defines a hook to run after each scenario
# Takes a screenshot of the failing scenario and saves it with the name
After do |scenario|
  if scenario.failed?
    name_of_scenario = scenario.name.gsub(/\s+/, '_').delete('"', "'", '(', ')')
    # save_page(name_of_scenario)
    take_screenshot(name_of_scenario)
  end
end
