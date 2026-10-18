class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.10.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:a3c8087fcb04b225a983c8d3995eb485853b4f8aaba8690f11e73a0906fe96dc"
    sha256 "a3c8087fcb04b225a983c8d3995eb485853b4f8aaba8690f11e73a0906fe96dc"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:4ec2d7ac2a01409c72c3edaef6f41b46aaaffd8535e5f4a1d6e6358e9f3a61c1"
    sha256 "4ec2d7ac2a01409c72c3edaef6f41b46aaaffd8535e5f4a1d6e6358e9f3a61c1"
  end

  depends_on "libpq" # pg_restore/psql/pg_dump for backup validation and restores

  def install
    bin.install "home"
  end

  def caveats
    <<~EOS
      Run `home` to set up your nodes and `home br setup` for backups, then
      `home install` to start the background jobs, one brew service each:
      home-backup, home-check, home-cleanup, home-deploy (see `home jobs`).
      Coming from hbr? `home br` picks up your hbr settings automatically.
    EOS
  end

  test do
    assert_match "home", shell_output("#{bin}/home version")
  end
end
