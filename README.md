# simple-pstack

A small selection of [Lauren Tan's pstack](https://github.com/cursor/plugins/tree/main/pstack) skills, simplified for Claude Code and Codex.

```sh
git clone https://github.com/marcinkonwiak/simple-pstack.git
cd simple-pstack
./install.sh
```

The installer copies the skills into `~/.claude/skills` and `~/.agents/skills` and records them in a `.simple-pstack-installed` file in each directory. After a `git pull`, run `./install.sh` again to update the copies. `./install.sh --remove` removes the recorded skills.

## claude.ai, Cowork, and cloud sessions

The repo is also a plugin marketplace, so your claude.ai account can pick the skills up and keep them current:

1. Open [Customize > Plugins](https://claude.ai/customize/plugins), select **Add > Add marketplace**, and enter `marcinkonwiak/simple-pstack`.
2. Install the `simple-pstack` plugin and turn on **Sync automatically** for the marketplace.

Every push to `main` then updates the skills on your account, in chat, Cowork, and Claude Code. The plugin has no `version`, so each commit counts as a new version. Skills from the plugin are named `simple-pstack:<skill>`.

In the Claude Code CLI you can install it the same way instead of running `install.sh`:

```sh
claude plugin marketplace add marcinkonwiak/simple-pstack
claude plugin install simple-pstack@simple-pstack
```

Use one route per machine, or every skill shows up twice.

MIT licensed. See [attribution](NOTICE.md).
