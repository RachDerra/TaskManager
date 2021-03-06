FactoryBot.define do
    factory :task do
      name { 'title1' }
      retail { 'content1' }
      dead_line { '2025-05-05'}
      status {'completed'}
      priority {'high'}
    end
    factory :second_task, class: Task do
      name { 'title2' }
      retail { 'content2' }
      dead_line { '2022-05-05'}
      status {'inprogress'}
      priority {'low'}
    end
  end