module ApplicationHelper
  def gravatar_for(user, options = { size: 80 })
    email_address = user.email
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag gravatar_url, class: "rounded shadow mx-auto d-block mt-3 mb-3"
  end
end
