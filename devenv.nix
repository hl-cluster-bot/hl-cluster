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
    ansible-lint.enable = true;
    check-yaml.enable = true;
    end-of-file-fixer.enable = true;
    gptcommit.enable = true;
    shfmt.enable = true;
    yamllint.enable = true;
  };

  overlays = [
    # Temporary workaround for https://github.com/NixOS/nixpkgs/issues/400373
    (final: prev: rec {
      python312 = prev.python312.override {
        packageOverrides = final: prev: {
          mocket = prev.mocket.overridePythonAttrs (oldAttrs: rec {
            disabledTests =
              oldAttrs.disabledTests
              ++ [
                "test_httprettish_httpx_session"
              ];
          });
        };
      };
      python312Packages = python312.pkgs;
    })
  ];
}
