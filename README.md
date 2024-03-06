This repository contains a few of my personal dotfiles that I use in my day-to-day workflow.

- [bashrc.d](./bashrc.d): essential, otherwise everything else becomes unproductive
- [nvim](./nvim): my primary text editor, I use VSCode sometimes for previewing markdown, or when I'm sharing my screen (otherwise it's impossible for other people to track my Neovim navigation)
- [tmux](./tmux): helps me manage terminal screens without leaving keyboard home row
- [kitty](./kitty): 

## How my Neovim looks like

### Python
![image](https://github.com/yuriescl/dotfiles/assets/26092447/a0215f98-a8e0-40ca-9bf2-7b71dcf2e40d)

### Go
![image](https://github.com/yuriescl/dotfiles/assets/26092447/5c11af10-00d8-43ff-b926-bfddef3a1479)

### TypeScript
![image](https://github.com/yuriescl/dotfiles/assets/26092447/06dd02f2-6703-4588-8ce7-4a57925d05f6)

### Markdown
![image](https://github.com/yuriescl/dotfiles/assets/26092447/fb7e8213-e2d6-4088-8526-1f812db0b62e)


## FAQ

- Which Linux distro do I use?
  - Fedora.
    - Why?
      - Because after more than a decade (literally) of using Ubuntu/Arch/Mint/PopOS/Gentoo and facing many annoying issues (including losing my system boot after a simple "apt upgrade"), Fedora has been the only distro that provides a great combination of bleeding edge but also stability. I don't mind reinstalling my OS once a year to get fresh software, but I also don't want to break my system when doing updates (e.g. `apt upgrade`, `pacman -Syu`, `dnf update`). This plus the fact that most Red Hat developers (including Gnome developers) use Fedora, so Fedora gets bugfixes and improvements directly from the upstream developers. And yes I like Gnome 40 and their design philosophy (by the way, good philosophy doesn't mean no bugs, but honestly I used Cinnamon/KDE/Xfce and they're also buggy as hell). I just really, really wish they come up with a stable extensions API, because it feels like every Gnome update breaks all the extensions. Well maybe at some point I help with that via contributing directly to the code, after all we can't expect to use free software and get all we want without contributing.
      - The famous Red Hat Enterprise Linux (RHEL), one of the most safest and well-maintained Linux enterprise distribution, is partially based on Fedora. So every update made on Fedora is in principle a future update on RHEL. Red Hat wants RHEL to be reliable, therefore, as a natural consequence, Fedora is made to be reliable in the first place.
      - Not bloated by default. Default config is great, just works. Installer is simple and lets you just install the system without having to configure every single small piece of thing possible (sorry Arch - and yes I've used archinstall and it's decent - but still, Arch is for people who want to learn instead of actually get things done). Other distros like Ubuntu/OpenSUSE/Manjaro do work reasonably well, but don't feel clean and vanilla like Fedora. This is all a bit subjective, I won't elaborate. To summarize the main reason for Fedora: I like Red Hat software and principles, but I want fresh packages, therefore, I can't use RHEL (or any of its clones) so I just use Fedora.

- Which IDE do I use?
  - None. Just NVIM + Terminal.
    - Why?
      - When you spend 8+ hours a day programming, for years, you have to make a decision:
        - Choice 1) Staying with "popular" IDEs (VS Code, IntelliJ, etc)
          - It's convenient but half of your screen will be filled with useless information
          - It's popular but popular doesn't mean more efficient
          - It's easy to use, but at some point, if you're a efficiency freak like me, you'll need to automate stuff or at least make some repetitive navigation tasks quicker. When you get to this point, good luck trying to be quicker in normal IDEs without developing wrist/shoulder issues.
          - IDEs automate a lot of things under the hood. All to get you to just press "Run" and see the software running. But, this is a receipt for disaster. I can't count how many times I've seen "expert" React.js developers not even knowing what is `eslint` and how to run it manually. That's because they use VS Code which automates everything for them. So in the end they become comfortable and lazy and then proceed to code without having any idea how their code gets compiled and executed.
        - Choice 2) Switch to NVIM+Terminal+Tmux, painfully learn and automate your setup, and then enjoy the speed/efficiency of navigation and control that those tools provide.
          - I don't use NVIM/Terminal because I want to be cool. I use it because it gets me to be 10x (or maybe more) faster doing my work (which is coding (or navigating code) most of the time). What's the point wasting time in life? Get things done faster and you'll be able to do more things.
          - All your expertise in NVIM/Terminal can be applied to servers. You'll be quicker navigating and won't have a hard time debugging issues server-side, because you'll be used to it already.
    - Have I tried switching back to an IDE?
      - Yes, I tried VS Code after they launched Copilot. It works but it's far less efficient than my NVIM setup. And guess what, Copilot works in NVIM as well nowadays.
      - After you spend a couple years perfecting your Terminal workflow, there's no going back, every tool will feel slow and unproductive.
    - Which plugins do I use in NVIM?
      - Just a couple of plugins that help quickly navigating in the filesystem tree (fzf + NERDTree + shortcuts), LSP (of course) and tree-sitter for improved syntax highlighting.
      - Why not use more plugins?
        - No need to. The less the better. This keeps my setup simple, predictable and performant.
      - But how do you get proper support for languages, like go-to definition, renaming variables, etc?
        - Those features are all provided by modern LSPs, which NVIM has native support for.
      - I do have a lot of utilitary shell scripts and aliases. NVIM alone isn't very productive, but when you introduce bash and tmux, it's very powerful.
    - For me, in the end, what matters is efficiency and feeling comfortable coding for many hours. My wrists hurt when using normal IDEs because of the huge amount of different hand movements required for navigation (Ctrl+Shift+whatever, arrow keys, etc). When using NVIM I don't feel any pain or discomfort due to how the shortcuts are centered around the same keyboard region, so my hands don't move much and this is good for wrist health. Even for Bash I don't use arrow keys usually, I prefer Ctrl+p and Ctrl+n for searching commands up and down, this keeps my hands in the same place.
