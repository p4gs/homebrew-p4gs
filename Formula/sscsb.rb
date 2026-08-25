class Sscsb < Formula
  desc "Opinionated, modular software supply chain security for small teams"
  homepage "https://github.com/p4gs/sscs-bootstrapper"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/p4gs/sscs-bootstrapper/releases/download/v0.2.0/sscsb-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "95f0b158909afc79887d7554888c09b4ef60c82423f083fb7aadffe496038ce0"
    end
    on_intel do
      url "https://github.com/p4gs/sscs-bootstrapper/releases/download/v0.2.0/sscsb-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "1b6171f8c43dce7b046254f96ba91f2813bd5e2136604d260fa2523612fd2f7b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/p4gs/sscs-bootstrapper/releases/download/v0.2.0/sscsb-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3a9371834ec3e798ea6d12b5e839babac1292df9a66757b0ddcd2288a69f1bea"
    end
  end

  def install
    bin.install "sscsb"
  end

  test do
    # Assert the version the formula claims, not merely that the binary runs:
    # a tap shipping older bytes under a newer formula would pass a bare
    # "does it execute" check.
    assert_match version.to_s, shell_output("#{bin}/sscsb --version")

    # And prove it works. sscsb refuses to run outside a git repository
    # (exit 2), so init has to happen inside the fixture.
    repo = testpath/"repo"
    repo.mkpath
    system "git", "-C", repo, "init", "-q"
    cd repo do
      system bin/"sscsb", "init"
    end
    assert_predicate repo/".sscsb/config.toml", :exist?
  end
end
