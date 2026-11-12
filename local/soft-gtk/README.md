# Catppuccin Soft GTK applications

Solid Macchiato windows, Mauve accents, semibold selected navigation/headings,
rounded controls, consistent focus/selection states and readable secondary text.
No content transparency or icon changes in CSS.

GTK3 overlay order: common.css, gtk3.css.
GTK4 overlay order: common.css, gtk4.css, nautilus.css, sidebar-corners.css,
libadwaita.css, navigation-surfaces.css, popover-feedback.css.

The application-specific rules account for baseline selector specificity and
Nautilus 51 widget names. The navigation-surface rules follow the actual
AdwNavigationSplitView direct-child ToolbarView hierarchy used by Settings.

Validated with native GTK3/GTK4 CssProvider parsers, Nautilus/Settings installed
resources and a constructed libadwaita widget selector test. Visually trialled
on Fedora 45 / GNOME 51. Apps generally require reopening after CSS changes.
Flatpak permissions are not changed; Qt/Electron interfaces are not covered.

Install under a distinct theme name, e.g. Catppuccin-Macchiato-Mauve-Soft-GTK.
Back up GTK selection and GTK4 CSS/assets links before switching them. Do not
replace unrelated gtk-4.0 files such as servers. See ../README.md for building.

Popover refinement: single painted surface, subdued border and soft shadow.
Nautilus rename-form feedback uses Macchiato red; only explicitly marked error
entries get a red border. The filename-validator UI does not expose an entry
error class, so rename focus remains Mauve rather than faking error detection.
