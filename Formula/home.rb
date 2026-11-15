class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.4"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:7a224bf801bb62085e70ce955973e912979503b4cba3cdecb234e69d956dc4e5"
    sha256 "7a224bf801bb62085e70ce955973e912979503b4cba3cdecb234e69d956dc4e5"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:1725229cca6d1a12f0e116fce5a133b79ceed35941635e3f9c7f685b3e110f04"
    sha256 "1725229cca6d1a12f0e116fce5a133b79ceed35941635e3f9c7f685b3e110f04"
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
