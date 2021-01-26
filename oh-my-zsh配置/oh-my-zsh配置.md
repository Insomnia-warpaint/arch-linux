# oh-my-zsh 安装与配置
- 下载 zsh 
```bash
sudo pacman -S zsh
```
- 下载 git
```bash
sudo pacman -S git
```
- 拉取 oh-my-zsh 仓库到文件夹,并安装。
```bash
mkdir -p ~/app/zsh
cd ~/app/zsh
git init
git clone https://github.com/ohmyzsh/ohmyzsh.git
进入 ohmyzsh 
cd ohmyzsh/tools
sh install.sh

下载ohmyzsh 语法高亮 和 命令补全插件。
cd ~/.oh-my-zsh/custom/plugins/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone https://github.com/zsh-users/zsh-autosuggestions
```
- 切换终端并配置 zsh
```bash
sudo chsh -s /bin/zsh 或者 sudo chsh -s $(which zsh)

切换完成后，编辑配置文件
先创建副本
cp ~/.zshrc ~/.zshrc.bak
vim ~/.zshrc
定位到 ZSH_THEME 设置主题
/ZSH_THEME

修改主题为 cloud ，网上有很多主题，可以自行百度下载
ZSH_THEME='cloud'

normal 模式 搜索 plugins
<Esc> /plugins 

设置常用插件
plugins=(    
        git    
        extract    
        autojump    
        web-search    
        zsh-autosuggestions    
        zsh-syntax-highlighting    
    
)

normal 模式 GG 到文件最后，设置别名
# 配置 nvim 别名 注: " = " 前后不能有空格，否则配置失败。
 alias vim="nvim"
 alias vi="nvim"
 alias config="~/.config"
 alias idea="~/dev/dev-tool/idea-IU-203.6682.168/bin/idea.sh"
 <Esc> :wq 保存退出。
 souce ~/.zshrc 
```
