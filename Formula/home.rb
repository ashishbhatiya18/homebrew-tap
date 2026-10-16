class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.7.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:bb7b916a5816b0e30694200afee455a1f5fb24fbdd15f2699018a999bd5029c4"
    sha256 "bb7b916a5816b0e30694200afee455a1f5fb24fbdd15f2699018a999bd5029c4"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:ea60d69391105cce91cec9a776cf836a6fd4b299027062eadf4fdbc9cd980718"
    sha256 "ea60d69391105cce91cec9a776cf836a6fd4b299027062eadf4fdbc9cd980718"
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
