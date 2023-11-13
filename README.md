# HunterX PDE (Personal Development Environment)

HunterX PDE is a personalized NeoVim distribution crafted to turbocharge the coding process while facilitating an in-depth understanding of IDE components at their fundamental level.

## Features

- F5 to Run Code: Sends command to terminal and outputs in buffer.
- Lazy Loading: Load scripts and plugins only when needed.
- Efficient Code Auto-completion: Rapid and precise code suggestion system.
- Auto-closing Bracket Pairs: Seamless closing of brackets for a streamlined coding experience.
- Live Code Biscuits: Real-time feedback and error highlighting.
- OneDarkPro and VSCode Colorschemes: Aesthetic and familiar color schemes for enhanced readability.
- Comment Toggler (gcc): Effortless comment toggling for code sections.
- Git Signs on Gutter: Visual indicators for Git changes within the gutter.
- Aesthetic Indent Lines and Brackets: Colorful and visually appealing representations for indent lines and brackets.
- Fast and Precise Cursor Navigation: Swift and accurate cursor movement and navigation with s<Regex>.
- File & Directory Manipulation using Oil: Efficient manipulation of files and directories.
- Mason Language Server Protocol Manager: Enhanced language server protocol manager for effective language support.
- Tab Out of Brackets: Quick navigation and tabbing out of brackets.
- Fuzzy File Navigation (pf): Efficient file search and navigation using fuzzy finding.
- Undo Tree Navigation (pv): Navigating through the undo tree for quick revisions.
- Colorpicker Slider (Ccc): Convenient color picking and selection using a slider.
- Parse Tree-based Syntax Highlighting: Precise and efficient syntax highlighting based on parse trees.
- Visual Colorcodes: Intuitive visual representation of color codes for enhanced understanding.
- Zen Mode: Distraction-free and immersive coding environment for focused work.
- Streamlined Workflow: Tailored settings and plugins to expedite coding tasks.
- Learning-Centric: Understand the foundational aspects of IDE functionalities.
- Personalized Keymaps: Intuitive keymaps for efficiency.

## Behaviours
- 2 space indentation set as default
- 4 space indentation for selected files: { "c", "cpp", "py", "java", "cs" }
- Uses system clipboard as default
- Highlights text for 150ms on yank
- Ability to scroll past EOF
- Ability to return to Normal mode using Esc in terminal
- Toggles relative number on insert and normal modes

## Installation

Linux:
```
git clone https://github.com/MidHunterX/HunterX-PDE ~/.config/nvim --depth 1 && nvim
```

Windows:
```
git clone https://github.com/MidHunterX/HunterX-PDE %%localappdata\nvim --depth 1 && nvim
```

## How It Works

HunterX PDE is designed to optimize the NeoVim environment with carefully selected settings and plugins. Each component is chosen to offer a seamless coding experience while diving into the core functionality of an IDE.
