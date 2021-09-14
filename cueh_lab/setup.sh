#!/bin/sh


check_priv()
{
    if [ "$(id -u)" -ne 0 ]; then
    echo "you must be root"
    exit 0

    fi
}

get_update()
{
    apt update && apt full-upgrade
}


install_ohmyzsh()
{
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    ln -s $HOME/repos/dotfiles/.config/.zshrc $HOME/repos/dotfiles/.config/.zshrc
}

get_nightly_metasploit()
{
    apt purge metasploit-framework
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
    msfupdate
}


get_pwndbg()
{   
    git clone https://github.com/pwndbg/pwndbg -o /opt/pwndbg/
    cd pwndbg
    ./setup.sh
}

get_web_tools()
{
    apt install wpscan dnsrecon sqlmap ffuf burpsuite masscan nikto nmap 
}

get_pwn_tools()
{
    apt install gdb r2 
    pip install pwntools
    wget -O /opt/ghidra_9.2.2.tar.gz https://github.com/NationalSecurityAgency/ghidra/archive/refs/tags/Ghidra_9.2.2_build.tar.gz
    extract /opt/ghidra_9.2.2.tar.gz
    bash -c "$(curl -fsSL http://gef.blah.cat/sh)" 
}

setup_wordlists()
{
  export WORDLISTS=/opt/wordlists
  mkdir /opt/wordlists
  wget -O /opt/wordlists/rockyou.txt.gz https://gitlab.com/kalilinux/packages/wordlists/-/blob/kali/master/rockyou.txt.gz
  extract rockyou.txt.gz
  gitclone https://github.com/danielmiessler/SecLists
}

get_cutter()
{
    wget https://github.com/rizinorg/cutter/releases/download/v2.0.2/Cutter-v2.0.2-x64.Linux.appimage -o /usr/bin/cutter.appimage
}

check_priv
get_update
install_ohmyzsh
get_nightly_metasploit
get_web_tools
get_pwn_tools
get_pwndbg
get_cutter
