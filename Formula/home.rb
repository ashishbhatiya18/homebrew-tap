class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.5"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:84299aa25517651d9922559f96d22f033a6925ea3161381e03653ff0efd8d482"
    sha256 "84299aa25517651d9922559f96d22f033a6925ea3161381e03653ff0efd8d482"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:63dc16614a2b4e886cedfa957000ca50f0331e5f258521bff5266ccbd1eccb4f"
    sha256 "63dc16614a2b4e886cedfa957000ca50f0331e5f258521bff5266ccbd1eccb4f"
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
