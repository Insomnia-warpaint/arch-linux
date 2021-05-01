# oh-my-zsh 安装与配置

- 下载 zsh

```bash
sudo pacman -S zsh
```


- 下载 oh-my-zsh-git

```bash
sudo pacman -S oh-my-zsh-git  zsh-autosuggestions  zsh-history-substring-search zsh-syntax-highlighting 

```

- 安装oh-my-zsh
```bash

cd /usr/share/oh-my-zsh/tools
./install.sh 或者 sh install.sh

```

- 修改配置文件
```vim
"修改主题为 ys 
ZSH_THEME='ys'

设置常用插件
plugins=(    
        git    
        extract    
        web-search     
)

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  

```