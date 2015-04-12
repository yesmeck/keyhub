users = [
  { username: 'meck', email: 'meck@keyhub.com', password: 'password', preferred_shell: '/bin/bash' },
  { username: 'ava', email: 'ava@keyhub.com', password: 'password', preferred_shell: '/bin/bash' },
  { username: 'amy', email: 'amy@keyhub.com', password: 'password', preferred_shell: '/bin/bash' },
]
User.seed(:username, *users)
