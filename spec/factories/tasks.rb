FactoryBot.define do
    factory :task do
      name { 'test_title' }
      retail { 'test_content' }
    end
    factory :second_task, class: Task do
      name { 'Test name' }
      retail { 'Test description' }
    end
  end