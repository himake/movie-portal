module SearchHelper
  def validate_query(query)
    query = '' if query.nil?
    query
  end

  def search_result_link(result)
    case result[:record_type]
    when 'Movie'
      movie_path(result[:record_id])
    when 'Serial'
      serial_path(result[:record_id])
    when 'Actor'
      actor_path(result[:record_id])
    when 'Director'
      director_path(result[:record_id])
    end
  end

  def search_render?
    current_page?(search_path) || current_page?(new_user_registration_path) ||
      current_page?(user_session_path) || current_page?(new_user_password_path) ||
      current_page?(edit_user_registration_path)
  end
end
