{
  config,
  inputs,
  pkgs,
  ...
}: let
  mcpServers = {
    cluster = {
      type = "http";
      url = "https://mcp.popov.wtf/mcp";
    };
  };

  vscodeMcpConfig = inputs.mcp-servers-nix.lib.mkConfig pkgs {
    fileName = "mcp.json";
    flavor = "vscode-workspace";
    settings.servers = mcpServers;
  };

  claudeCodeMcpConfig = inputs.mcp-servers-nix.lib.mkConfig pkgs {
    fileName = ".mcp.json";
    flavor = "claude-code";
    settings.servers = mcpServers;
  };
in {
  imports = [inputs.mcp-servers-nix.devenvModules.default];

  env = {
    ANSIBLE_CONFIG = "${config.env.DEVENV_ROOT}/ansible/ansible.cfg";
    KUBECONFIG = "${config.env.DEVENV_ROOT}/kubeconfig";
    SOPS_AGE_KEY_FILE = "${config.env.DEVENV_ROOT}/age.key";
  };

  packages = with pkgs; [
    age
    ansible
    cilium-cli
    cloudflared
    fluxcd
    git
    go-task
    helmfile
    jq
    kubeconform
    kubectl
    kubefetch
    kubernetes-helm
    kustomize
    moreutils
    sops
    stern
    yaml-language-server
    yq
  ];

  git-hooks.hooks = {
    alejandra.enable = true;
    ansible-lint = {
      enable = true;
      settings.subdir = "ansible";
    };
    check-yaml.enable = true;
    deadnix.enable = true;
    shellcheck.enable = true;
    statix.enable = true;
    end-of-file-fixer.enable = true;
    shfmt.enable = true;
    trufflehog.enable = true;
    yamllint.enable = true;
  };

  scripts = {
    generate-mcp-vscode.exec = ''
      mkdir -p .vscode
      ln -sf ${vscodeMcpConfig} .vscode/mcp.json
    '';

    generate-mcp-claude-code.exec = ''
      ln -sf ${claudeCodeMcpConfig} .mcp.json
    '';
  };

  mcp-servers.settings.servers = mcpServers;
}
