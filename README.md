This repository contains a couple of my personal dotfiles that I use in all my Linux setups.

- [bashrc.d](./bashrc.d)
- [nvim](./nvim)
- [tmux](./tmux)

## FAQ

- Which Linux distro do I use?
  - Fedora.
    - Why?
      - Because after decades (literally) of using Ubuntu/Arch/Mint/PopOS/Gentoo and facing many annoying issues (including losing my system boot after a simple "apt upgrade"), Fedora has been the only distro that provides a great combination of bleeding edge but also stability. I don't mind reinstalling my OS once a year. This plus the fact that most Red Hat developers use Fedora so Fedora gets the bugfixes and improvements before any other GNOME-based distro. And yes I like Gnome 40 and their design philosophy (by the way, good philosophy doesn't mean no bugs, but honestly I used Cinnamon/KDE/Xfce and they're also buggy as hell).
      - The famous Red Hat Enterprise Linux (RHEL), one of the most safest and well-maintained Linux enterprise distribution, is partially based on Fedora. So every update made on Fedora is in principle a future update on RHEL. Red Hat wants RHEL to be reliable, therefore, as a natural consequence, Fedora is made to be reliable in the first place.
      - Not bloated by default. Default config is great, just works. Installer is simple and lets you just install the system without having to configure every single small piece of thing possible (sorry Arch - and yes I've used archinstall and it's decent - but still, Arch is for people who want to learn instead of actually get things done). Other distros like Ubuntu/OpenSUSE/Manjaro do work reasonably well, but don't feel clean and vanilla like Fedora. This is all a bit subjective, I won't elaborate. To summarize the main reason for Fedora: I like Red Hat software and principles, but I want fresh packages, therefore, I can't use RHEL (or any of its clones) so I just use Fedora.

- Which IDE do I use?
  - None. Just NVIM + Terminal.
    - Why?
      - When you spend 8+ hours a day programming you got pretty much two choices:
        - Choice 1) Staying with "popular" IDEs (VS Code, IntelliJ, etc)
          - It's convenient but half of your screen will be filled with useless information
          - It's popular but popular doesn't mean more efficient
          - It's easy to use, but at some point, if you're a efficiency freak like me, you'll need to automate stuff or at least make some repetitive navigation tasks quicker. When you get to this point, good luck trying to be quicker in normal IDEs without breaking your wrist/shoulders.
          - If you don't know what your IDE is doing under the hood, sorry but you're a newbie to programming. Learn more, get better, understand the tools and the flows. Stop pressing "Run" and start running things manually, and then, you'll see that IDEs do a lot of useless bloated stuff that just slows down your coding/execution/debugging.
        - Choice 2) Switch to NVIM+Terminal+Tmux, painfully learn and automate your setup, and then enjoy the speed/efficiency of navigation and control that those tools provide.
          - I don't use NVIM/Terminal because I want to be cool. I use it because it gets me to be 10x (or maybe more) faster doing my work (which is coding (or navigating code) most of the time). What's the point wasting time in life? Get things done faster and you'll be able to do more things.
          - All your expertise in NVIM/Terminal can be applied to servers. You'll be quicker navigating and won't
          have a hard time debugging issues server-side, because you'll be used to it already.
    - Have I tried switching back to an IDE?
      - Yes, I tried VS Code after they launched Copilot. It's cool but since I'm too slow outside of my NVIM/Terminal setup, I went back to NVIM. And guess what, Copilot works in NVIM as well, so all good.
    - Which plugins do I use in NVIM?
      - Just a couple of plugins that help quickly navigating in the filesystem tree (fzf + NERDTree + shortcuts), LSP (of course) and some good syntax highlighters.
      - Why not use more plugins?
        - No need to. The less the better. This keeps my setup simple, predictable and performant.
      - I do have a lot of utilitary shell scripts and aliases. NVIM alone isn't very productive, but when you introduce bash and tmux, it's very powerful.
      - For me, in the end, what matters is efficiency and feeling comfortable coding for many hours. My wrists hurt when using normal IDEs because of the huge amount of different hand movements required for navigation. When using NVIM I don't feel any pain or discomfort due to how the shortcuts are centered around the same keyboard region, so my hands don't move much and this is good for wrist health.
