class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.7"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:7560cf60b30143a26e1304d8a7b4f75c36a053f521ee6549c94259a669ffbbdc"
    sha256 "7560cf60b30143a26e1304d8a7b4f75c36a053f521ee6549c94259a669ffbbdc"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:05beb3f0afbe95255627f3daf19c5c9c4dea2fc5893b2c532f0cad2de2cb578f"
    sha256 "05beb3f0afbe95255627f3daf19c5c9c4dea2fc5893b2c532f0cad2de2cb578f"
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
