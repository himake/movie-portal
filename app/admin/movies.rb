ActiveAdmin.register Movie do

  controller do
    before_action :show
    def show
      redirect_to admin_root_path unless current_user.admin? || current_user.editor?
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column(:release_date) { |movie| movie.release_date&.strftime('%d-%m-%Y') }
    column(:duration) { |movie| movie.duration&.strftime('%H:%M') }
    column 'Category' do |movie|
      Category.find(movie.category_id)
    end
    column 'Director' do |movie|
      Director.find(movie.director_id)
    end
    actions
  end

  filter :name
  filter :duration
  filter :release_date

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, as: :text
      f.input :release_date, label: 'Released date', as: :datepicker
      f.input :duration, as: :time_picker
      f.input(:category, as: :searchable_select)
      f.input(:director, as: :searchable_select)
      f.input :video_key
      f.input :image
    end
    f.actions
  end

  permit_params do
    permitted = [:name, :image, :description, :video_key, :release_date, :duration, :category_id, :country_id,
                 :director_id, { countries: [:country_id] }]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
end
