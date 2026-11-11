# Personal Catppuccin Soft variants

Macchiato + Mauve refinements for GNOME Shell, GTK3/GTK4 and Adwaita folder icons.
These are personal maintenance overlays, not a promise of universal GNOME support.
Original upstream credits and GPL licensing remain in force.

## Build theme variants (does not select them)

Requires bash, Python 3 and sassc. From the repository root:

```sh
bash local/build-soft.sh /path/to/empty-output-directory
```

This copies the upstream theme source into temporary build space, builds the
Macchiato Mauve Dark baseline (14px rounding, opaque fallback shell background),
and creates distinct Soft Shell and Soft GTK variants. No system configuration,
GTK links, icon selection or Blur My Shell settings are changed.

Back up existing user themes and settings before installing/selecting a variant.
GTK4/libadwaita support uses user CSS overrides, not a guaranteed stable theming
API. Reopen applications after changes. Keep your backups outside this repo.

See the component READMEs for scope, overlay ordering and icon generation.
