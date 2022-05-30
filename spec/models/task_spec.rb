require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Essai de validation' do
    context 'Si le titre de la tâche est vide' do
      it 'Être pris dans la validation' do
        task = Task.new(name: '', retail: 'Essai échoué')
        expect(task).not_to be_valid
      end
    end
      context 'Si les détails de la tâche sont vides' do
      it 'Être pris dans la validation' do
        task = Task.new(name: '', retail: '')
        expect(task).not_to be_valid
      end
    end
    context 'Si le titre et les détails de la tâche sont décrits' do
      it 'Laissez-passer de validation' do
        task = Task.new(name: 'Titre valide', retail: 'Description valide')
        expect(task).to be_valid
      end
    end
  end
  describe 'fonction de recherche' do
    let!(:task) { FactoryBot.create(:task)}
    let!(:second_task) { FactoryBot.create(:second_task) }
    context 'Si une recherche floue dun titre est effectuée à laide de la méthode scope' do
      it "Les tâches contenant des termes de recherche sont réduites." do
        expect(Task.search_name('1')).to include(task)
        expect(Task.search_name('1')).not_to include(second_task)
        expect(Task.search_name('1').count).to eq 1
      end
    end
    context 'Si une recherche détat est effectuée à laide de la méthode scope' do
      it "Les tâches dont le statut correspond exactement sont réduites." do
        expect(Task.search_status('completed')).to include(task)
        expect(Task.search_status('completed')).not_to include(second_task)
        expect(Task.search_status('completed').count).to eq 1
      end
    end
    context 'Recherches de titres et de statuts ambigus dans la méthode du champ dapplication' do
      it "Les tâches sont réduites à celles qui contiennent des termes de recherche dans le titre et qui correspondent exactement au statut." do
        expect(Task.search_name('1').search_status('completed')).to include(task)
        expect(Task.search_name('1').search_status('completed')).not_to include(second_task)
        expect(Task.search_name('1').search_status('completed').count).to eq 1
      end
    end
  end
end
