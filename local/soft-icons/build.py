from pathlib import Path
import colorsys,re,configparser
from PIL import Image
src=Path('/usr/share/icons/Adwaita'); dst=Path.home()/'.local/share/icons/Adwaita-Catppuccin-Mauve'
assert not dst.exists(), 'Refusing to overwrite existing overlay'
dst.mkdir(parents=True)
target=colorsys.rgb_to_hls(198/255,160/255,246/255)
base_l=colorsys.rgb_to_hls(164/255,202/255,238/255)[1]
def recolor(r,g,b):
 h,l,s=colorsys.rgb_to_hls(r/255,g/255,b/255)
 if not (0.50<h<0.69 and s>0.12):return r,g,b
 # Anchor the folder's main light blue surface to exact Macchiato Mauve;
 # retain relative shading across back flap, highlights and small emblems.
 nl=max(0,min(1,l+(target[1]-base_l)))
 ns=target[2] if s>0.25 else min(s,target[2])
 return tuple(round(c*255) for c in colorsys.hls_to_rgb(target[0],nl,ns))
count=0; directories=set()
for p in list(src.rglob('folder*')) + list(src.rglob('user-desktop.*')):
 if p.parent.name!='places' or p.suffix not in ('.svg','.png') or 'symbolic' in p.parts:continue
 rel=p.relative_to(src);out=dst/rel;out.parent.mkdir(parents=True,exist_ok=True)
 if p.suffix=='.svg':
  def sub(m):
   rgb=tuple(int(m[1][i:i+2],16) for i in (0,2,4));return '#%02x%02x%02x'%recolor(*rgb)
  out.write_text(re.sub(r'#([0-9a-fA-F]{6})\b',sub,p.read_text()))
 else:
  im=Image.open(p).convert('RGBA');im.putdata([(*recolor(*px[:3]),px[3]) for px in im.getdata()]);im.save(out)
 directories.add(str(rel.parent));count+=1
config=configparser.ConfigParser(interpolation=None);config.optionxform=str
config.read(src/'index.theme')
new=configparser.ConfigParser(interpolation=None);new.optionxform=str
new['Icon Theme']={'Name':'Adwaita Catppuccin Mauve','Comment':'Adwaita folders recoloured for Catppuccin Macchiato Mauve; other icons inherited','Inherits':'Adwaita','Directories':','.join(sorted(directories))}
for d in directories:new[d]=dict(config[d])
with (dst/'index.theme').open('w') as f:new.write(f)
print('Created overlay:',dst,'folder assets:',count)
