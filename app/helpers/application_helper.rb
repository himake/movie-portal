module ApplicationHelper
  def is_exist(attribute)
    return t('no_ifomation') if attribute.nil? || attribute == ""
    attribute
  end
end
