# zsh-bws
This plugin provides a collection of features to simplify and improve the retrieval of secrets from Bitwarden Secret Manager.

## Installation

## Usage
### bws_get
```
bws_get [-i secret_id | -k secret_key ]
```
Gets the secret value by id or key and prints it to the standard output. If neither id nor key is specified, the function asks to select from the list of all secrets present on the server.
### bws_get_full
```
bws_get_full [-i secret_id | -k secret_key ] [-o output_format ]
```
Gets the entire secret by id or key and prints it to the standard output with the indicated format. If none of id or key is indicated the function asks to select from the list of all secrets present on the server.

The supported formats are the same as the bws command, namely: json, yaml, env, table, tsv, none. The default is json.
### bws_copy
```
bws_copy [-i secret_id | -k secret_key ]
```
Gets the secret value by id or key and copy it to the clipboard. If neither id nor key is specified, the function asks to select from the list of all secrets present on the server.

To copy to the clipboard it uses the clipboard command. You can customize the command via the ZSH_BWS_COPY_CMD variable.

## Alias

| Alias | Command |
| --- | --- |
| `bwsg` | `bws_get` |
| `bwsgf` | `bws_get_full` |
| `bwsc` | `bws_copy` |
| `bwsl` | `bws secret list` |

## Examples
### Add a ssh key to ssh agent

On Bitwarden Secret Manager you can save ssh keys. With this trick you can easily add your private key to the agent by selecting it among your secrets and without it residing on the computer disk.

```
ssh-add - <<< $(bwsg)
```

