### MASTERMIND

#### High-level project plan:

1. Build all project requirements locally, test, run, and initiate final Pull Request so both partners have the final version within local repos.
2. Move final main branch to Replit interface
    - Option to 'test' a limited interface, to avoid back-tracking or reengineering features that run locally but not within Replit.
3. Proposed Git workflow: `git init` from `main` branch, create new branch for `testing`, and each dragon pushes features completed to remote, so that each alligator can pull those features down for next iteration.

    - Commands to run for a "gut check" (making sure you have the correct remote, and branch from that remote)
      - ```bash
        $ git remote -v
        $ git branch -a
        $ git checkout <branch name>
        $ git checkout -b <branch name>
        $ git status
        ```
        - First two commands are informational (am I linked to the correct repo, and am I on the correct branch from that repo?)
        - Next two commands are imperative (switch to the correct branch if it exists, or create and switch to that branch if it does not exist)
        - Final command is informational, to ensure the prior 4 commands have landed you on the correct branch, from the correct remote origin.

    - Commands to run (as dragon, once work is ready to be committed)
      - Assumes working branch is named `testing`
        ```bash
        $ git status
        $ git add <file>
        $ git commit -m "<message>"
        $ git push origin testing
        ```
    - Commands to run (as alligator switching to dragon, to pull down partner's work from remote to local repo)
      - Assumes working branch is named `testing`
        ```bash
        $ git status
        $ git pull origin testing
        ```
