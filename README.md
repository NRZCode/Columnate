# Columnate

Awk script to format text columnate

### USAGE
```sh
awk -v width=COLUMNS -v height=LINES -v page=PAGE -f columnate.awk FILE
# Example to print using terminal full wide and full height
awk -v width=$COLUMNS -v height=$LINES -f columnate.awk FILE
```
### DESCRIPTION
Format text columnate

```
# OPTIONS
#   General options
#     width     Output is formatted for a display columns wide.
#     height    Display output with the given height instead of using the full text.
#               (80 columns default)
#     page      Display a page number paginate output
```
