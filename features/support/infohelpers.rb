# frozen_string_literal: true

# Screenshot helper file.
module InfoHelpers
  # def get_attr(locator, attrib)
  # Nokogiri::HTML(page.body).css(locator).attribute(attrib).to_s
  # end
  # def get_css(loc)
  #  Nokogiri::HTML(page.body).css(loc)
  # end
  def take_screenshot(name = nil)
    time = Time.now.strftime('%Y%m%d_%H%M%S')
    file_name = time + '_' + name.tr('^a-zA-Z0-9#', '') + '.png'
    page.driver.render("#{Dir.pwd}/features/results/#{file_name}", full: true)
    puts "Location of screenshot: #{file_name}"
  end
end
World(InfoHelpers)
