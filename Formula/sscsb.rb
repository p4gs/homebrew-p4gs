class Sscsb < Formula
  desc "Opinionated, modular software supply chain security for small teams"
  homepage "https://github.com/p4gs/sscs-bootstrapper"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/p4gs/sscs-bootstrapper/releases/download/v0.4.0/sscsb-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "7bcb4380eda7baabc6b62ada923715772bbdefe1713477fde34050d0871a51fb"
    end
    on_intel do
      url "https://github.com/p4gs/sscs-bootstrapper/releases/download/v0.4.0/sscsb-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "37aedaed61e0d4e742504b83a68359586bfd3d58097f785b9cd3c842c8b7198a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/p4gs/sscs-bootstrapper/releases/download/v0.4.0/sscsb-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fa973ce164f71aedd9ebfadf748e10e6bc1cde12e57d417202b1bd7ce15ebf79"
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
