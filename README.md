# ssh-command-action
Action to run a command on a remote server via ssh

## Usage
```yaml
uses: D3rHase/ssh-command-action@latest
with:
  HOST: ${{secrets.HOST}}                             # Remote server address / ip - Required: true
  PORT: ${{secrets.PORT}}                             # Remote server port -  Default: 22 - Required: false
  USER: ${{secrets.USER}}                             # Remote server user - Required: true
  PRIVATE_SSH_KEY: ${{secrets.PRIVATE_SSH_KEY}}       # Private ssh key registered on the remote server - Required: true
  COMMAND: ${{secrets.COMMAND}}                       # Command to be executed - Default: echo Hello world! - Required: false
```
