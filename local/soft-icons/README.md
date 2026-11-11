# Adwaita Macchiato Mauve folder overlay

`python3 build.py` creates Adwaita-Catppuccin-Mauve in the user icon directory.
Requires Python 3, Pillow and installed Adwaita icons. Refuses to overwrite an
existing overlay. Recolours full-colour folder and user-desktop SVG/PNG assets,
preserving shape and shading; other icons inherit Adwaita unchanged.

After building, run:

```sh
gtk-update-icon-cache -f -t ~/.local/share/icons/Adwaita-Catppuccin-Mauve
gsettings set org.gnome.desktop.interface icon-theme Adwaita-Catppuccin-Mauve
```

If User Theme X controls icons, set its light/dark icon selections to this name
as well. GNOME native purple is only an approximation of exact Macchiato Mauve.
Back up previous icon/accent settings before changing them. Restore the former
icon theme to undo the overlay; never edit system Adwaita assets in place.

The script transforms installed Adwaita assets; generated assets are not
committed. Preserve the upstream Adwaita licensing when redistributing assets.
