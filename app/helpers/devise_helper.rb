module DeviseHelper
  def bootstrap_devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    resource.errors.full_messages.each do |error_message|
      html += <<-EOF
      <div class="alert alert-danger" role="alert">
        <div class="alert-message-center">
          #{error_message}
        </div>
      </div>
      EOF
    end
    html.html_safe
  end
end
