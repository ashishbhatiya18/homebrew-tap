class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.9.1"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:71c7c7f25ba977490b59b666ff545cc4265117d093d23bdaf3b9bfd90b5a8d5d"
    sha256 "71c7c7f25ba977490b59b666ff545cc4265117d093d23bdaf3b9bfd90b5a8d5d"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:134ed2e2de108e3e0353e52592f0d05063ad1e36b5125be1c75fc9104c7e4326"
    sha256 "134ed2e2de108e3e0353e52592f0d05063ad1e36b5125be1c75fc9104c7e4326"
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
