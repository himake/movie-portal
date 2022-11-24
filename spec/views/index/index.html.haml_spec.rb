require 'rails_helper'

RSpec.describe '/', type: :view do
  it 'has a request.fullpath that defined' do
    expect(controller.request.fullpath).to eq root_path
  end
end
