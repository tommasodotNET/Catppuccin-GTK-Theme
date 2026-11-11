#!/usr/bin/env bash
# Build only; never apply theme settings or change live GTK links.
set -euo pipefail
root=$(cd -- "$(dirname -- "$0")/.." && pwd)
: "${1:?Usage: bash local/build-soft.sh EMPTY_OUTPUT_DIRECTORY}"
mkdir -p -- "$1"
out=$(cd -- "$1" && pwd)
if [ -n "$(find "$out" -mindepth 1 -maxdepth 1 -print -quit)" ]; then
  echo 'Output directory must be empty.' >&2; exit 1
fi
work=$(mktemp -d)
trap 'rm -rf -- "$work"' EXIT
cp -a "$root/themes" "$work/themes"
mkdir "$work/build"
BATCH_MODE=true bash "$work/themes/install.sh" -d "$work/build" -a mauve -m dark -s standard --tweaks macchiato --shell opacity 1 radius 14
python3 - "$root" "$work/build/Catppuccin-Macchiato-Mauve-Dark" "$out" <<'PY'
import pathlib,shutil,sys
r,b,o=map(pathlib.Path,sys.argv[1:])
shell=o/'Catppuccin-Macchiato-Mauve-Soft';shell.mkdir()
shutil.copytree(b/'gnome-shell',shell/'gnome-shell',symlinks=True)
f=shell/'gnome-shell/gnome-shell.css'
with f.open('a') as h:
 for name in ('soft.css','refinement.css','calendar.css','quick-readability.css'):
  h.write('\n'+(r/'local/soft-shell'/name).read_text())
(shell/'index.theme').write_text('[Desktop Entry]\nType=X-GNOME-Metatheme\nName='+shell.name+'\n')
gtk=o/'Catppuccin-Macchiato-Mauve-Soft-GTK';shutil.copytree(b,gtk,symlinks=True)
p=gtk/'index.theme';p.write_text(p.read_text().replace(b.name,gtk.name))
for version in (3,4):
 names=['common.css',f'gtk{version}.css']
 if version==4:names+=['nautilus.css','sidebar-corners.css','libadwaita.css','navigation-surfaces.css']
 overlay='\n'+'\n'.join((r/'local/soft-gtk'/n).read_text() for n in names)
 for name in ('gtk.css','gtk-dark.css'):
  p=gtk/f'gtk-{version}.0'/name;p.write_text(p.read_text()+overlay)
# GTK variant must not advertise an unrefined copy of the Shell theme.
shutil.rmtree(gtk/'gnome-shell')
print('Built:',shell,gtk,sep='\n')
PY
