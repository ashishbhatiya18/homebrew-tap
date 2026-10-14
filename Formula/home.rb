class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.6.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:224e683a6674d6daf7d74001d1d7d8fadf9165816e16d4b85caef576cc6f4953"
    sha256 "224e683a6674d6daf7d74001d1d7d8fadf9165816e16d4b85caef576cc6f4953"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:743750400e0b1d18c0ac39ba15639932580388c0462bd5ffbd4782ffbe7fdd76"
    sha256 "743750400e0b1d18c0ac39ba15639932580388c0462bd5ffbd4782ffbe7fdd76"
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
