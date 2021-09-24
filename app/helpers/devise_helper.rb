module DeviseHelper
  def bootstrap_devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    resource.errors.full_messages.each do |error_message|
      html += <<-EOF
      <div class="alert alert-danger rounded-0 py-4" role="alert">
        #{error_message}
      </div>
      EOF
    end
    html.html_safe
  end
end
