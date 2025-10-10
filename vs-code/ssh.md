```
sudo apt update
sudo apt install -y git openssh-client
```

```
ssh-keygen -t ed25519 -C "rubensojunior6@gmail.com"
```

```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

```
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

joga em settings -> ssh

```
sudo apt install xclip && cat ~/.ssh/id_ed25519.pub | xclip -sel clip
```
