class Sscsb < Formula
  desc "Opinionated, modular software supply chain security for small teams"
  homepage "https://github.com/p4gs/sscs-bootstrapper"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/p4gs/sscs-bootstrapper/releases/download/v0.2.1/sscsb-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "501d1ec2eeeb7b123049be933c1014221938222c3f956eeddc1e331d65dd0c4a"
    end
    on_intel do
      url "https://github.com/p4gs/sscs-bootstrapper/releases/download/v0.2.1/sscsb-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "10d709507c4645183b65549ae79831602b8089cf384f9fb3f34caa5d6b7991e1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/p4gs/sscs-bootstrapper/releases/download/v0.2.1/sscsb-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b90d036c295eb85e11d85d52601558aa79a85478b1a245bd63a3af9993285d06"
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
