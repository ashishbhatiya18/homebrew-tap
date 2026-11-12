class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.3"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:9d82da39c3571fcb00111259424c493a1e003968bbfb2de4a6a0df2ab2e4107f"
    sha256 "9d82da39c3571fcb00111259424c493a1e003968bbfb2de4a6a0df2ab2e4107f"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:be3b9700b0d553182f01cbecb5097a4d498f2b9b20e15b911373814ca4cebf73"
    sha256 "be3b9700b0d553182f01cbecb5097a4d498f2b9b20e15b911373814ca4cebf73"
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
