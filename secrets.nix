let
  glados = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFxC+6/A2qKBPdOF4kVwAmVh7Zc5WW89LPFbvoVIMZm7 glados-agenix";
in {
  "hosts/GLaDOS/github_ssh.age".publicKeys = [glados];
}
