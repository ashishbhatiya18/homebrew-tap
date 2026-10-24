class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.1"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:5dcb7a5da8763783bd5e2602d32e9021e4f0449884318b1156f7c96f7ca0594f"
    sha256 "5dcb7a5da8763783bd5e2602d32e9021e4f0449884318b1156f7c96f7ca0594f"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:ef446688955fef52c94e1a47549b4601478d37d514ae08a5361c50ce649c3a02"
    sha256 "ef446688955fef52c94e1a47549b4601478d37d514ae08a5361c50ce649c3a02"
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
