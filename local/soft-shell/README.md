# Catppuccin Macchiato Mauve Soft — GNOME Shell

Foreground styling for GNOME 51, designed to complement Blur My Shell without
changing its pipeline, transparency or refraction settings.

Append overlays in this order to a Macchiato Mauve Dark shell build with 14px
rounding and shell opacity 1:

1. soft.css
2. refinement.css
3. calendar.css
4. quick-readability.css

Features: rounded Quick Settings controls, unified split buttons, semibold
labels, darker inactive tiles, quiet panel/dock feedback, softer notifications,
and a balanced date menu. Notification width is 21em; calendar uses natural
width. No forced height clipping. Application styling is separate.

Validated using GNOME 51's native St CSS loader; visually trialled on Fedora 45.
Older/newer GNOME versions may need selector adjustments. Use a separate theme
name such as Catppuccin-Macchiato-Mauve-Soft, not the upstream baseline name.
See ../README.md for building. Back up theme-selection settings before applying.
