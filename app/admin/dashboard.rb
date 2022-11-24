ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  controller do
    before_action :show
    def show
      redirect_to user_root_path unless current_user.admin? || current_user.editor?
    end
  end

  content title: proc { I18n.t('active_admin.dashboard') } do

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "Recent Comments" do
          ul do
            Comment.last(15).map do |comment|
              li link_to(comment.body, admin_comment_path(comment))
            end
          end
        end
      end

      column do
        panel "Info" do
          para "Welcome to admin panel."
        end
      end
    end
  end
end
