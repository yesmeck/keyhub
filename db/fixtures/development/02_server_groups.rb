server_groups = [
  { id: 1, name: 'web', project_id: 1 },
  { id: 2, name: 'app', project_id: 1 },
  { id: 3, name: 'db', project_id: 1 },
  { id: 4, name: 'web', project_id: 2 },
  { id: 5, name: 'app', project_id: 2 },
  { id: 6, name: 'db', project_id: 2 },
]

ServerGroup.seed(:id, *server_groups)
