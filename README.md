# ssh-command-action

Action to run a command on a remote server via ssh

## Usage

```yaml
uses: Lingepumpe/ssh-command-action@{version}
with:
  ssh_host: ${{secrets.SSH_HOST}} # Remote server address / ip - Required: true
  ssh_port: ${{secrets.SSH_PORT}} # Remote server port -  Default: 22 - Required: false
  ssh_user: ${{secrets.SSH_USER}} # Remote server user - Required: true
  ssh_private_key: ${{secrets.SSH_PRIVATE_KEY}} # Private ssh key registered on the remote server - Required: true
  ssh_host_fingerprint: ${{secrets.SSH_HOST_FINGERPRINT}} # Public ssh key fingerprint, viewable via ssh-keyscan -H $HOST -p $PORT - Required: false
  command: "echo 'Success'" # Command to be executed - Default: echo 'hello world' - Required: false
```
