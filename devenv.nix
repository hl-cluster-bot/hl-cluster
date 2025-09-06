{
  config,
  pkgs,
  ...
}: {
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

  enterShell = ''
    echo "Tool versions:"
    echo "ansible: $(ansible --version | head -1 | cut -d' ' -f3 | tr -d ']')"
    echo "cilium: $(cilium version --client 2>/dev/null | grep -o 'v[0-9.]*' | head -1)"
    echo "flux: $(flux version --client 2>/dev/null | grep -o 'v[0-9.]*' | head -1)"
    echo "kubectl: $(kubectl version --client 2>/dev/null | head -1 | cut -d' ' -f3)"
    echo ""
    echo "Configuration files:"
    echo "KUBECONFIG: $([ -f "$KUBECONFIG" ] && echo "✓ exists" || echo "✗ missing")"
    echo "SOPS_AGE_KEY_FILE: $([ -f "$SOPS_AGE_KEY_FILE" ] && echo "✓ exists" || echo "✗ missing")"
  '';
}
