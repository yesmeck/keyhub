users = [
  { id: 1, username: 'meck', email: 'meck@keyhub.com', password: 'password', preferred_shell: '/bin/bash' },
  { id: 2, username: 'ava', email: 'ava@keyhub.com', password: 'password', preferred_shell: '/bin/bash' },
  { id: 3, username: 'amy', email: 'amy@keyhub.com', password: 'password', preferred_shell: '/bin/bash' },
]

User.seed(:id, *users)
