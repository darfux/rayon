desc "Unit data import"

namespace :db do
task :import_unit , [:args] => :environment do |t, args|
  units = %w{南开大学 喀什师范学院 延边大学}
  units.each do |t|
    next if(Unit.find_by(name: t))
    unit = Unit.new(name: t)
    unit.save!
  end
end
end