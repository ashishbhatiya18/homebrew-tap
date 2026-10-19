class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.11.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:56391014ed35f1d234a4747395bd2fa598650094f854cb0e2377d3cb0a5ad460"
    sha256 "56391014ed35f1d234a4747395bd2fa598650094f854cb0e2377d3cb0a5ad460"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:87ce3696b2cb97ba12fd70bd79a2987aa271093582396853af731432cdb2166d"
    sha256 "87ce3696b2cb97ba12fd70bd79a2987aa271093582396853af731432cdb2166d"
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
