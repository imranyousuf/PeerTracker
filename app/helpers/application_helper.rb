module ApplicationHelper
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "success"
      when :error
        "error"
      when :alert
        "alert"
      when :notice
        "notice"
      else
        flash_type.to_s
    end
  end
end
