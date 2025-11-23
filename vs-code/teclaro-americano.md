usar:

EUA, inter. alt.

se não funcionar o cedilha: 

```
sudo sh -c "grep -q '^GTK_IM_MODULE=cedilla$' /etc/environment || echo 'GTK_IM_MODULE=cedilla' >> /etc/environment"
```
