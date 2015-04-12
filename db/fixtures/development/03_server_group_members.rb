server_group_members = [
  { id: 1, server_group_id: 1, user_id: 1, role: 'root' },
  { id: 2, server_group_id: 2, user_id: 1, role: 'root' },
  { id: 3, server_group_id: 3, user_id: 1, role: 'root' },

  { id: 4, server_group_id: 1, user_id: 2, role: 'user' },
  { id: 5, server_group_id: 2, user_id: 2, role: 'user' },
  { id: 6, server_group_id: 3, user_id: 2, role: 'root' },

  { id: 7, server_group_id: 1, user_id: 3, role: 'user' },
  { id: 8, server_group_id: 2, user_id: 3, role: 'user' },
]

ServerGroupMember.seed(:id, *server_group_members)
