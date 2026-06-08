class KubernetesTools < Formula
  desc "Set of scripts that simplify daily Kubernetes operations"
  homepage "https://github.com/haooliveira84/kubernetes-tools"
  url "https://github.com/haooliveira84/kubernetes-tools/archive/refs/tags/v2.3.4.tar.gz"
  sha256 "4d690d2ae143dda52a2f93b035875fd7afab44bfdf1d6cefcbfa77e28dea1c09"
  license "MIT"
  version "2.3.4"

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
