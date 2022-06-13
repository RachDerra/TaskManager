require 'rails_helper'
RSpec.describe 'Fonction de gestion des users', type: :system do
  
  describe 'Nouvelle fonction de création' do
    context 'Lors de la création de nouvelle user' do
      it 'Le user créé saffiche' do
        visit new_user_path
        fill_in 'Name', with: 'myuser'
        fill_in 'Email', with: 'myuser2@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirm', with: 'password'
        click_on 'Create my account'
        expect(page).to have_content 'You are logged in.'

      end
    end
  end

  describe 'Fonction daffichage de liste' do
    context 'Lors de la transition vers lécran de liste' do
      it 'Une liste des tâches créées saffiche' do 
        visit tasks_path        
        
        expect(page).to have_content 'Password'

      end
    end
  end

  describe 'Fonction de connexion' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user_admin) { FactoryBot.create(:user_admin) }
    context 'Après sêtre connecté' do
      it 'La liste des tâches saffiche' do
        visit new_session_path
        fill_in 'Email', with: 'myuser@example.com'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
        expect(page).to have_content 'Task'
      end
    end

    context 'Cliquer sur Profile' do
      before do 
        visit new_session_path
        fill_in 'Email', with: 'myuser@example.com'
        fill_in 'Password', with: 'password'
        click_on 'Log in'
      end
      it 'Les informations de lutilisateur en cours saffiche' do
        click_on 'Profile'
        expect(page).to have_content 'page of'
      end

      it 'Lorsquun utilisateur général passe à lécran de détails dune autre personne, il passe à lécran de la liste des tâches.' do
        visit user_path(user_admin.id)
        expect(page).to have_content 'access this page'
      end

      it 'Lutilisateur se déconnecte' do
        click_on 'Logout'
        expect(page).to have_content 'logged out'
      end
    end
  end

  describe 'Testez lécran de gestion.' do
    before do
      FactoryBot.create(:user)
      FactoryBot.create(:user_admin)
      visit new_session_path
    end
    context 'À partir de lécran de la liste des tâches.' do
      it 'Les utilisateurs administratifs ont accès à lécran de gestion.' do
        fill_in "Email", with: "useradmin@example.com"
        fill_in "Password", with: "password"
        click_on "Log in"
        click_on "Management page"
        expect(page).to have_content "Users"
      end
      it 'Les utilisateurs généraux ne peuvent pas accéder à lécran de gestion.'do
        fill_in "Email", with: "myuser@example.com"
        fill_in "Password", with: "password"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "Can't access the administration page !"
      end
    end
    context 'A partir de lécran de la liste des utilisateurs.' do
      before do
        fill_in "Email", with: "useradmin@example.com"
        fill_in "Password", with: "password"
        click_on "Log in"
        visit admin_users_path
      end
      it 'Les utilisateurs administratifs peuvent enregistrer de nouveaux utilisateurs.' do
        click_on "New User"
        fill_in "Name", with: "cow"
        fill_in "Email", with: "mowmow@mow.com"
        fill_in "Password", with: "mowmow"
        fill_in "Password confirmation", with: "mowmow"
        click_on "Create User"
        expect(page).to have_content "User create succesfully"
      end
      it 'Les utilisateurs administratifs ont accès à lécran des détails de lutilisateur.' do
        visit admin_users_path
        click_on "myuser",match: :first
        expect(page).to have_content "User Tasks"
      end
      it 'Les utilisateurs administratifs peuvent modifier les utilisateurs à partir de lécran de modification de lutilisateur.' do
        visit admin_users_path
        click_on "useradmin",match: :first
        click_on "Edit"
        fill_in "Password", with: "mowmowmow"
        fill_in "Password confirmation", with: "mowmowmow"
        click_on "Update User"
        expect(page).to have_content "User edited !"
      end
      it 'Les utilisateurs administratifs peuvent supprimer des utilisateurs.' do
        sleep 3.0
        visit admin_users_path
        click_on "myuser",match: :first
        click_on "Destroy",match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "User has been delete !"
      end
    end
  end 
end