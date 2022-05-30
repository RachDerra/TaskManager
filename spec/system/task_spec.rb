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
        select '2024', from: 'task[dead_line(1i)]'
        select 'June', from: 'task[dead_line(2i)]'
        select '6', from: 'task[dead_line(3i)]'
        select 'completed', from: 'task[status]'
        select 'high', from: 'task[priority]'
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
        visit task_path(task.id)
        page.html
        expect(page).to have_content 'description'
       end
     end
  end
  describe 'Fonction daffichage trié' do
    context 'Si les tâches sont classées par ordre décroissant de date et de heure de création' do
      it 'Les nouvelles tâches apparaissent en haut de la liste.' do
       task = FactoryBot.create(:task, name: 'task1', retail: 'description1')
       task = FactoryBot.create(:task, name: 'task2', retail: 'description2')
       task = FactoryBot.create(:task, name: 'task3', retail: 'description3')
       task = FactoryBot.create(:task, name: 'task4', retail: 'description4') 
       visit tasks_path
       tasks_list = all('p')
       expect(tasks_list[0]).to have_content 'description4'
      end
    end
 end
 describe 'fonction de triage' do
    context 'Cliquez sur le lien Trier par date limite.' do
      it "Une liste de tâches triées par ordre décroissant de date de fin s'affiche." do
        task = FactoryBot.create(:task),FactoryBot.create(:second_task)
        visit tasks_path
        click_on "Sort by Deadline"
        sleep 1.0
        task_list = all('p')
        expect(task_list[0]).to have_content 'content1'
      end
    end
    context 'Appuyez sur le lien Trier par priorité' do
      it "Une liste de tâches triées par ordre de priorité croissant s'affiche." do
        task = FactoryBot.create(:task),FactoryBot.create(:second_task)
        visit tasks_path
        click_on "Sort by Priority"
        sleep 1.0
        task_list = all('p')
        expect(task_list[0]).to have_content 'content1'
      end
    end
    context 'Si une recherche floue est effectuée sur le titre' do
      it "Réduit par les tâches contenant des termes de recherche." do
      sleep 1.0
      visit tasks_path
      fill_in 'name', with: 'title1'
      click_on 'Search'
      expect(page).to have_content '1'
      end
    end
    context 'Lorsqu-une recherche de statut est effectuée.' do
      it "Les tâches dont le statut correspond exactement sont réduites." do
        visit tasks_path
        select "completed", from: "number"
        click_on 'Search'
        expect(page).to have_content 'completed'
      end
    end
    context 'Lorsque des recherches de titres et de statuts ambigus sont effectuées' do
      it "Les tâches sont réduites à celles qui contiennent des termes de recherche dans le titre et qui correspondent exactement au statut." do
  
      visit tasks_path
      fill_in 'name', with: 'title2'
      select "inprogress", from: "number"
      click_on 'Search'
      expect(page).to have_content '2'
      expect(page).to have_content 'inprogress'
      end
    end
  end
end