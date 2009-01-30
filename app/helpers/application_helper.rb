module ApplicationHelper
  
  # Calculate the appropriate years for copyright
  def copyright_years
    start_year = 2009
    end_year = Date.today.year
    if start_year == end_year
      "#{start_year}"
    else
      "#{start_year}&#8211;#{end_year}"
    end
  end
  
  def errors_on?(*objects)
    objects.any? do |object|
      object = instance_variable_get("@#{object}") if object.kind_of?(Symbol)
      (!object.nil?) && (object.errors.count > 0)
    end
  end
  
  # Returns a Gravatar URL associated with the email parameter.
  # See: http://douglasfshearer.com/blog/gravatar-for-ruby-and-ruby-on-rails
  def gravatar_url(email, gravatar_options={})
    # Default highest rating.
    # Rating can be one of G, PG, R X.
    # If set to nil, the Gravatar default of G will be used.
    gravatar_options[:rating] ||= "G"
    
    # Default size of the image.
    # If set to nil, the Gravatar default size of 32px will be used.
    gravatar_options[:size] ||= "32px"
    
    # Default image url to be used when no gravatar is found
    # or when an image exceeds the rating parameter.
    gravatar_options[:default] ||= "#{request.protocol}#{request.host_with_port}/images/avatar_32x32.png"
    
    # Build the Gravatar url.
    grav_url = 'http://www.gravatar.com/avatar.php?'
    grav_url << "gravatar_id=#{Digest::MD5.new.update(email)}" 
    grav_url << "&rating=#{gravatar_options[:rating]}" if gravatar_options[:rating]
    grav_url << "&size=#{gravatar_options[:size]}" if gravatar_options[:size]
    grav_url << "&default=#{gravatar_options[:default]}" if gravatar_options[:default]
    return grav_url
  end
  
end
