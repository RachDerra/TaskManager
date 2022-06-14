require 'rails_helper'
RSpec.describe 'Fonction de gestion des étiquettes', type: :system do
  let!(:label) { FactoryBot.create(:label) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user)}
  before do
    visit new_session_path
    fill_in "session[email]",with: "myuser@example.com"
    fill_in "session[password]",with: "password"
    click_on "Log in"
  end

  describe 'Nouvelle fonction de création' do
    context 'Si une nouvelle étiquette est créée.' do
      it 'Les étiquettes créées sont affichées.' do
        visit new_label_path
        fill_in "label[name]",with: "abc"
        click_on "Create Label"
        expect(page).to have_content 'Label was successfully created.'
      end
    end
  end

  describe 'Fonction de listage' do
    context 'Lorsque le passage à lécran de synthèse est effectué' do
      it 'Une liste des étiquettes qui ont été créées saffiche.' do
        visit labels_path
        expect(page).to have_content 'Blue'
      end
    end
  end

  describe 'fonction denregistrement' do
    context 'Lors de lenregistrement dune nouvelle tâche' do
      it 'Il est également possible denregistrer plusieurs étiquettes.' do
            visit new_task_path
            fill_in 'task[name]',with: 'test1'
            fill_in 'task[retail]',with: 'test2'
            select '2024', from: 'task[dead_line(1i)]'
            select 'June', from: 'task[dead_line(2i)]'
            select '6', from: 'task[dead_line(3i)]'
            select 'completed', from: 'task[status]'
            select 'high', from: 'task[priority]'
            check 'Blue'
            click_on "Create Task"
            expect(page).to have_content 'Blue'
         end
      end
  

    context 'Lorsque vous passez à lécran de détails de la tâche.' do
      it 'Les étiquettes peuvent également être contrôlées.' do

        visit new_task_path
            fill_in 'task[name]',with: 'test1'
            fill_in 'task[retail]',with: 'test2'
            select '2024', from: 'task[dead_line(1i)]'
            select 'June', from: 'task[dead_line(2i)]'
            select '6', from: 'task[dead_line(3i)]'
            select 'completed', from: 'task[status]'
            select 'high', from: 'task[priority]'
            check 'Blue'
            click_on "Create Task"

        visit tasks_path
        click_on "test1"
        expect(page).to have_content 'Blue'
      end
    end
  end

  describe 'fonction de recherche' do
    context 'Cliquez sur la recherche de létiquette.' do
        it 'Les tâches avec cette étiquette sont affichées.' do
          visit new_task_path  
          fill_in 'task[name]',with: 'test1'
          fill_in 'task[retail]',with: 'test2'
          select '2024', from: 'task[dead_line(1i)]'
          select 'June', from: 'task[dead_line(2i)]'
          select '6', from: 'task[dead_line(3i)]'
          select 'completed', from: 'task[status]'
          select 'high', from: 'task[priority]'
          check 'Blue'
          click_on "Create Task"
          expect(page).to have_content 'Blue'
          visit tasks_path
          select 'Blue'
          click_on 'Search'
          expect(page).to have_content 'Blue'
        end
      end
  end
end