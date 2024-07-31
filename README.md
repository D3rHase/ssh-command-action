# What is this? / How to use?

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Latest Release](https://img.shields.io/github/v/release/D3rHase/ssh-command-action?style=flat-square)

This is a GitHub Action designed to run commands on a remote server using SSH. It allows you to securely execute commands on a remote server from your GitHub workflow, making it ideal for deployment, server management, and other remote tasks.

## Table of Contents

- [Features](#features)
- [Usage](#usage)
  - [Action Example](#action-example)
  - [Parameters](#parameters)
  - [Secrets Configuration](#secrets-configuration)
  - [Adding an SSH Key to your Server](#adding-an-ssh-key-to-your-server)
  - [Getting the Host Fingerprint](#getting-the-host-fingerprint)
- [How to implement in your workflow Example](#how-to-implement-in-your-workflow)
- [License](#license)

## Features

- **Secure**: Uses SSH with key-based authentication to securely execute commands on remote servers.
- **Flexible**: Run any command supported by the shell on the remote server.
- **Easy Integration**: Simple to include in your GitHub Actions workflow.

## Usage

### Action Example

Here's an action example of how to use this `ssh-command-action`.

#### Single Command Example:
```yaml
    - name: Run remote command via SSH
      uses: D3rHase/ssh-command-action@latest
      with:
        host: ${{ secrets.HOST }}
        port: ${{ secrets.PORT }}
        user: ${{ secrets.USER }}
        private_key: ${{ secrets.PRIVATE_KEY }}
        host_fingerprint: ${{ secrets.HOST_FINGERPRINT }}
        command: echo 'Hello, World!'
```

#### Multiline Command Example:

```yaml
    - name: Run multiple remote commands via SSH
      uses: D3rHase/ssh-command-action@latest
      with:
        host: ${{ secrets.HOST }}
        port: ${{ secrets.PORT }}
        user: ${{ secrets.USER }}
        private_key: ${{ secrets.PRIVATE_KEY }}
        host_fingerprint: ${{ secrets.HOST_FINGERPRINT }}
        command: |
          cd /path/to/your/directory
          git pull origin main
          npm install
          npm run build
```

### Parameters

You can use plain text instead of the secrets for these values directly in your action, but it is highly recommended to use GitHub Secrets for sensitive information to ensure privacy and security. See [Secrets Configuration](#secrets-configuration).

- `host`: The remote server address (IP or domain) - **Required**.
- `port`: The port to connect to on the remote server - *Default: 22*.
- `user`: The username for SSH access - **Required**.
- `private_key`: The private SSH key to authenticate with the remote server - **Required**.
- `host_fingerprint`: The public SSH key fingerprint of the remote server for verification - **Optional**.
- `command`: The command to execute on the remote server - **Required**.

## Secrets Configuration

To keep your credentials secure, store sensitive information like `host`, `port`, `user`, and `private_key` as [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets). You can add these secrets in your repository's settings under `Secrets and variables` > `Actions`.

## Adding an SSH Key to Your Server

To use this action, you'll need to set up an SSH key on your server. Here's how to do it:

1. **Generate an SSH Key Pair** on your local machine (if you don't have one already):

    ```sh
    ssh-keygen -t rsa -b 4096
    ```

    This command creates a new SSH key using the RSA algorithm with a 4096-bit key length.

2. **Add the SSH Key to the Server**:

    Copy the public key (`~/.ssh/id_rsa.pub`) to your server using the `ssh-copy-id` command:

    ```sh
    ssh-copy-id user@your-server-ip
    ```

    Replace `user` with your server's username and `your-server-ip` with the IP address of your server. This command adds your public key to the `~/.ssh/authorized_keys` file on the server.

3. **Test the SSH Connection**:

    Verify that you can connect to your server using the SSH key:

    ```sh
    ssh user@your-server-ip
    ```

4. **Store the SSH Key in GitHub Secrets**:

    Go to your repository on GitHub, navigate to `Settings` in your repository > `Secrets and variables` > `Actions`, and add a new repository secret named `PRIVATE_KEY`. Paste the contents of your private key (`~/.ssh/id_rsa`) into this secret.

    **Note**: Ensure your private key remains confidential. Do not share it publicly.

## Getting the Host Fingerprint

To ensure you're connecting to the correct server and to prevent man-in-the-middle attacks, you can verify the server's host fingerprint. Here's how to obtain it:

1. **Connect to your server** using SSH from your local machine:

    ```sh
    ssh user@your-server-ip
    ```

2. **Get the SSH host key fingerprint**:

    After connecting, run the following command on your server:

    ```sh
    ssh-keygen -lf /etc/ssh/ssh_host_rsa_key.pub
    ```

    Replace `/etc/ssh/ssh_host_rsa_key.pub` with the path to your server's SSH public key file if it's different.

3. **Copy the fingerprint** displayed by the command. It should look something like this:

    ```
    2048 SHA256:ABC123def456ghi789... (RSA)
    ```

4. **Store the Host Fingerprint in GitHub Secrets**:

    Go to your repository on GitHub, navigate to `Settings` in your repository > `Secrets and variables` > `Actions`, and add a new repository secret named `HOST_FINGERPRINT`. Paste the fingerprint into this secret.

## How to implement in your workflow

To use this action, simply include it in your GitHub workflow YAML file as shown in the example below.

```yaml
name: Example workflow file

on:
  push:
    branches:
      - main

jobs:
  remote-command:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v2

    - name: Run remote command via SSH
      uses: D3rHase/ssh-command-action@latest
      with:
        host: ${{ secrets.HOST }}
        port: ${{ secrets.PORT }}
        user: ${{ secrets.USER }}
        private_key: ${{ secrets.PRIVATE_KEY }}
        host_fingerprint: ${{ secrets.HOST_FINGERPRINT }}
        command: echo 'Hello, World!'

    - name: Notify Command Success
      run: echo "Command executed on ${{ secrets.HOST }} successfully!"
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

Feel free to adapt any part of this template further based on your specific requirements.
