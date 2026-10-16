class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.8.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:5b216e161ff81e2dce026317d636bf05900ab4c06fbd70b7263b04cc6ef0a370"
    sha256 "5b216e161ff81e2dce026317d636bf05900ab4c06fbd70b7263b04cc6ef0a370"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:455ced80a85eb197690af43892f4d2c9a246c2ab7d12412d99b2cd906a91b5a6"
    sha256 "455ced80a85eb197690af43892f4d2c9a246c2ab7d12412d99b2cd906a91b5a6"
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
