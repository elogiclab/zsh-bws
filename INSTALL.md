# Requirements
The following should be installed and on your PATH:
* [bws](https://bitwarden.com/help/secrets-manager-cli/) Bitwarden Secrets Manager CLI
* [jq](https://github.com/stedolan/jq) to manipulate the JSON
* [fzf](https://github.com/junegunn/fzf) for selecting from multiple items
* A utility available for your environment to copy text from a terminal, e.g. xclip for Xorg or clipboard for Wayland. By default zsh_bws uses clipboard, but you can set the command via the `ZSH_BWS_COPY_CMD` variable.
* The `BWS_ACCESS_TOKEN` variable is set at execution time.

# Installation
## OhMyZsh (manual)
1. Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)

    ```sh
    git clone https://github.com/elogiclab/zsh-bws ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-bws
    ```

2. Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):

    ```sh
    plugins=( 
        # other plugins...
        zsh-bws
    )
    ```
## Antigen
Add to your `~/.zshrc` the following line:

```sh
antigen use oh-my-zsh
# Other bundles
antigen bundle elogiclab/zsh-bws@main
```




