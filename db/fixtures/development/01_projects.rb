projects = [
  {id: 1, name: 'Facebook'},
  {id: 2, name: 'Twitter'}
]

Project.seed(:id, *projects)

Project.find(1, 2).each do |project|
  User.find(1, 2, 3).each do |user|
    project.users << user
  end
end
