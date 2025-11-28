# Cadeau Crypt

An absolutely ridiculous Secret Santa pair generator, in Prolog.
Generates (Giver, Encrypted URL) so the receiver is kept secret until the URL (hosted elsewhere) is visited.

## Usage

Uses [swipl](https://www.swi-prolog.org/).
```
% swipl santa.pl
[...]
?- find_and_print.
Giver                URL
-------------------- -----------------------------------------------------------
Mike                 https://santa.val.run/ewogICJkYXRhIjoiWkRlV2l6THM0MDlDWkFYL2Z2aEx6TWhrRUJUMDJxTmlRS2VaWnVZUXhRcHhXZz09IiwKICAiaXYiOiJPTGVGU0taZzNBc2JON0tyIiwKICAidGFnIjoiK1FDZ2dHVzBtaW5VUnVLTkpVQkFHUT09Igp9
Carol                https://santa.val.run/ewogICJkYXRhIjoiV3QrM0o1SElyeXRZLzMwMGRGL3ZoWS8yWFBpTGVadE8zL0xXcEloUk9oMWFDWHJJIiwKICAiaXYiOiJRNXZ3NWpWWndYVDZ0RVpTIiwKICAidGFnIjoiTlB1NXZyVllXT3VmbFJNdnpsMmNZZz09Igp9
Marsha               https://santa.val.run/ewogICJkYXRhIjoia0huc2lhY3pIbFVldkRJWEwwSjc5UWdxalVLOEgvS0haMGhvUWVyYWVmKzZYZ0JWWVE9PSIsCiAgIml2IjoiL1h4TTdudGhWb2c3VnlLZSIsCiAgInRhZyI6ImxVWkVqcm9oaG1KaklsUGt3MC9LaXc9PSIKfQ%3D%3D
[...]
?- 
```
