require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(username: 'Alejandro', password: 'password') }

    describe 'validations' do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
      it { should validate_presence_of(:password_digest) }
      it { should validate_uniqueness_of(:session_token) }
      it { should validate_length_of(:password).is_at_least(6) }
    end

    describe 'password encryption' do
      it 'does not save passwords to the database' do
          User.create!(username: 'grandma', password: 'bestgrannyever')
          grandma = User.find_by(username: 'grandma')
          expect(grandma.password).not_to be('bestgrannyever')
      end

      context 'saves passwords properly' do
        it 'encrypts the password using BCrypt' do
          expect(BCrypt::Password).to receive(:create)
          User.new(username: 'captain_miller', password: 'omaha_beach')
        end
        it 'properly sets the password reader' do
          user = User.new(username: 'fabianKnight', password: 'cranberry')
          expect(user.password).to eq('cranberry')
        end
      end
    end

    describe 'session token' do
        it 'assigns a session_token if one is not given' do
            subject.valid?
            expect(subject.session_token).not_to be_nil
        end

        it 'uses `#reset_session_token!` to reset a session token on a user' do
            old_session_token = subject.session_token
            new_session_token = subject.reset_session_token!
            expect(old_session_token).not_to eq(new_session_token)
        end
    end

    describe '#is_password?' do
        it 'verifies if a password is correct' do
          expect(user.is_password?('password')).to be true
          expect(user.is_password?('not_password')).to be false
        end
    end

    describe '::find_by_credentials' do
        before { user.save! }
        it 'finds a user by their username and password' do
          expect(User.find_by_credentials('Alejandro', 'password')).to eq(user)
        end
        it 'returns nil if the credentials are incorrect' do
          expect(User.find_by_credentials('Alejandro', 'not_password')).to be nil
        end
    end
end


