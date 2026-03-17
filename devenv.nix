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
}
