# pacmark - A Declarative pacman Wrapper

## Why This Project Exists

- **The Problem:** Desktop Linux systems accumulate unnecessary packages over time — apps installed briefly, forgotten, and left to clutter your system. This is a nightmare for small disks and system hygiene (run `pacman -Qq | wc -l` to see how many packages you have installed).

- **Why Current Solutions Fall Short:** Tools like NixOS are powerful but overly complex for users who don’t need complete reproducibility, just a clean, lightweight system.

- **My Solution:** A simple declarative `pacman` wrapper that:
    - Lets you define a clean "reset state" for your system
    - Provides tools to reset your system back to that declarative state, whenever you choose
    - Forces you to explicitly define what you want to keep, avoiding clutter by design.

## Setup

1. **Download dependencies:**
    ```bash
    sudo pacman -S bash pacman diffutils sed xargs make sudo
    ```

2. **Clone and install:**
    ```bash
    git clone https://github.com/mantinhas/pacmark.git && cd pacmark && make install
    ```
