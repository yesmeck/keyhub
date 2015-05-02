json.set! 'shim-delay', 7
json.users do
  @members.each do |member|
    json.set! member.username do
      json.ssh_public_key member.ssh_public_key
      json.name member.name
      json.perm 'ALL=NOPASSWD: ALL'
      json.preferred_shell member.preferred_shell
    end
  end
end
