users = [
  { id: 1, username: 'meck', email: 'meck@keyhub.com', password: 'password', preferred_shell: '/bin/bash' },
  { id: 2, username: 'ava', email: 'ava@keyhub.com', password: 'password', preferred_shell: '/bin/bash' },
  { id: 3, username: 'amy', email: 'amy@keyhub.com', password: 'password', preferred_shell: '/bin/bash', ssh_public_key: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzOH+y6ES9Gy5hAXrMGJxrqNfg4NY+CkG7Z8i1J6p9FzmCbNfFP1Rx1ACnVBtlaS3difzyZto3P30ONQa/XXRAq+2XTVWc7GZpDRVUvNrkwlfyj0lVU3F4i53GGJjJ+C9uVmQT2/YjPVbdLaK9XpqPh79yMI0C/Z0Ox2PWzZ4EGPW3NAAIEPi0kcfDjvN5PaFPo3bbRmLp8v/xyJeYfColzk6U6nvlTwzdRUtEr4ACjIUOtxs5zv3LGN4FmnupH1x18gGtJkcLdNnK4tIapTAH62RCZOS/KbODZSzYLZf58LrZS1Pv+/FDGnyrXe93LbVdxAEO5CxvSY7xAD71FsE5 yesmeck@gmail.com' },
]

User.seed(:id, *users)
