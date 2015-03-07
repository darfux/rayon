desc "Title data import"

namespace :db do
task :import_title , [:args] => :environment do |t, args|
  titles = %w{助教 讲师 副教授 教授 高级工程师 高级实验师 兼职教授 讲座教授 副研究员 研究员}
  titles.each do |t|
    next if(Title.find_by(name: t))
    title = Title.new(name: t)
    title.save!
  end
end
end