class KubernetesTools < Formula
  desc "Set of scripts that simplify daily Kubernetes operations"
  homepage "https://github.com/haooliveira84/kubernetes-tools"
  url "https://github.com/haooliveira84/kubernetes-tools/archive/refs/tags/v2.3.3.tar.gz"
  sha256 "34f0f898a96da1bb96335ee559ee99e32c19a71ebbf309ce6f602b5b2106347c"
  license "MIT"
  version "2.3.3"

  depends_on "kubernetes-cli"
  depends_on "jq"

  def install
    bin.install Dir["bin/*"]
    pkgshare.install "completion"
  end

  def caveats
    <<~EOS
      Enable tab completion:
        ktools --init

      Or source completions manually:
        bash:  source #{opt_pkgshare}/completion/__completion
        zsh:   autoload -U compaudit compinit bashcompinit && compaudit && compinit && bashcompinit
               source #{opt_pkgshare}/completion/__completion
        fish:  cp #{opt_pkgshare}/completion/kubernetes-tools.fish \\
                  ~/.config/fish/completions/

      Optional (recommended):
        brew install fzf        # nicer interactive pickers
        brew install colordiff  # colored kdiff output
    EOS
  end

  test do
    assert_match "Kubernetes Tools", shell_output("#{bin}/ktools -h")
    assert_match "kctx",  shell_output("#{bin}/ktools -h")
    assert_match "klogs", shell_output("#{bin}/ktools -h")
  end
end
