require 'rails_helper'
RSpec.describe 'Fonction de gestion des tâches', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
  end
  describe 'Nouvelle fonction de création' do
    context 'Lors de la création de nouvelle tâche' do
      it 'La tâche créée saffiche' do
        visit new_task_path
        fill_in 'Name', with: 'title_test'
        fill_in 'Retail', with: 'content_test'
        click_on 'Create Task'
        expect(page).to have_content 'title_test'

      end
    end
  end
  describe 'Fonction daffichage de liste' do
    context 'Lors de la transition vers lécran de liste' do
      it 'Une liste des tâches créées saffiche' do
        task = FactoryBot.create(:task, name: 'task', retail: 'description')   
        visit tasks_path        
        current_path
        Task.count
        page.html

        expect(page).to have_content 'task'

      end
    end
  end
  describe 'Fonction daffichage détaillée' do
     context 'Lors de la transition vers un écran de détails de tâche' do
       it 'Le contenu de la tâche correspondante saffiche' do
        task = FactoryBot.create(:task, name: 'task', retail: 'description') 
        visit tasks_path(task.id)
        page.html
        expect(page).to have_content 'description'
       end
     end
  end
end