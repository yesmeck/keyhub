Project.seed(:name, { name: 'Facebook' }, { name: 'Twitter' })

user = User.find_by(username: 'amy')
user.projects += Project.all
user.save
