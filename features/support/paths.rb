# frozen_string_literal: true

# Module that holds the paths to the various pages in the app.
module NavigationHelpers
  # Path mapping
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    # If the page is not found, prints an error
    else
      begin
        page_name =~ /the (.*) page/
        path_components = Regexp.last_match[1].split(/\s+/)
        # path_components = $1.split(/\s+/)
        send(path_components.push('path').join('_').to_sym)
        # self.send(path_components.push('path').join('_').to_sym)
      rescue Object
        msg1 = "Can't find mapping from \"#{page_name}\" to a path.\n"
        msg2 = "Now, go and add a mapping in #{__FILE__}"
        raise  msg1 + msg2
      end
    end
  end
end

World(NavigationHelpers)
