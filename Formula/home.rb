class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.2"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:daba5493cd8fc22dd897cc430e96011ef437c7b58ff97275d6e1df18b2f8a06d"
    sha256 "daba5493cd8fc22dd897cc430e96011ef437c7b58ff97275d6e1df18b2f8a06d"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:136b24b665323db9c82529ed9f3998cf586248ecc6ec0de55fa0e02508a0c121"
    sha256 "136b24b665323db9c82529ed9f3998cf586248ecc6ec0de55fa0e02508a0c121"
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
