{
  config,
  pkgs,
  ...
}: {
  env = {
    KUBECONFIG = "${config.env.DEVENV_ROOT}/kubeconfig";
    SOPS_AGE_KEY_FILE = "${config.env.DEVENV_ROOT}/age.key";
  };

  packages = with pkgs; [
    age
    cilium-cli
    cloudflared
    fluxcd
    git
    go-task
    helmfile
    jq
    kubeconform
    kubectl
    kubernetes-helm
    kustomize
    moreutils
    sops
    stern
    yq
  ];

  git-hooks.hooks = {
    alejandra.enable = true;
    check-yaml.enable = true;
    end-of-file-fixer.enable = true;
    gptcommit.enable = true;
    shfmt.enable = true;
  };
}
