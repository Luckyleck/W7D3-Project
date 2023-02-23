RSpec.describe UsersController, type: :request do
    describe 'GET #new' do
      it 'renders the new user template' do
        get new_user_url
       expect(response).to render_template(:new)
     end
   end
  
   describe 'POST #create' do
     let(:user_params) do
       { user: { username: 'John Jacobs', password: 'penguins' } }
     end
    
     context 'with valid params' do
       it 'creates a new user' do
         post users_url, params: user_params
         expect(User.last.username).to eq('John Jacobs')
       end
       it 'redirects to the login page' do
         post users_url, params: user_params
         expect(response).to redirect_to(new_session_url)
       end
     end
    
     context 'with invalid params' do
       let(:user_params) do
         { user: { username: '', password: 'russianbling' } }
       end
       it 'does not create a new user' do
         expect { post users_url, params: user_params }.not_to change(User, :count)
       end
       it 're-renders the new user template' do
         post users_url, params: user_params
         expect(response).to render_template(:new)
       end
     end
   end
end
