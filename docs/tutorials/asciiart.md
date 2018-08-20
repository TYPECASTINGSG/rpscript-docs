# Ascii Art with Figlet

Various ways to display Pretty Ascii art.

## __Source__

**simple_figlet.rps**
<script src="https://gist.github.com/wei3hua2/4228c5e5c70826779f7f1da866749d56.js?file=simple_figlet.rps"></script>

running the command `rps simple_figlet.rps` will print the text 'casper' with the font below.

```
             ('-.      .-')     _ (`-.    ('-.  _  .-')   
            ( OO ).-. ( OO ).  ( (OO  ) _(  OO)( \( -O )  
   .-----.  / . --. /(_)---\_)_.`     \(,------.,------.  
  '  .--./  | \-.  \ /    _ |(__...--'' |  .---'|   /`. ' 
  |  |('-..-'-'  |  |\  :` `. |  /  | | |  |    |  /  | | 
 /_) |OO  )\| |_.'  | '..`''.)|  |_.' |(|  '--. |  |_.' | 
 ||  |`-'|  |  .-.  |.-._)   \|  .___.' |  .--' |  .  '.' 
(_'  '--'\  |  | |  |\       /|  |      |  `---.|  |\  \  
   `-----'  `--' `--' `-----' `--'      `------'`--' '--' 
```


module used :
<span class="badge">basic</span> <span class="badge">figlet</span>

---
---

**sentence_figlet.rps**
<script src="https://gist.github.com/wei3hua2/4228c5e5c70826779f7f1da866749d56.js?file=sentence_figlet.rps"></script>

Break the sentence by whitespace and display each section every 1 second.

module used :
<span class="badge">basic</span> <span class="badge">figlet</span>

---
---

**write_all_fonts.rps**
<script src="https://gist.github.com/wei3hua2/4228c5e5c70826779f7f1da866749d56.js?file=write_all_fonts.rps"></script>

Download the font list, convert the text "rp script" for each font, and save it to the file "result_fonts.txt".

module used :
<span class="badge">basic</span> <span class="badge">figlet</span> <span class="badge">downloading</span> <span class="badge">open</span> <span class="badge">file</span>

---
---

**print_all_fonts.rps**
<script src="https://gist.github.com/wei3hua2/4228c5e5c70826779f7f1da866749d56.js?file=print_all_fonts.rps"></script>

Print the text 'rp script' on the terminal font by font.

module used :
<span class="badge">basic</span> <span class="badge">figlet</span> <span class="badge">downloading</span> <span class="badge">file</span>

### __Docker__
[source](https://gist.githubusercontent.com/wei3hua2/4228c5e5c70826779f7f1da866749d56/raw/b3d93df830908c0deefc74c9b73a429c64a379d1/Dockerfile)
```
docker run typecasting/rpscript-example-printfiglets
```

---
---