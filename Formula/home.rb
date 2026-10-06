class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.5.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:575f52f2de45f621cb5ee9e59687bcdb5e5a82f2f8625ddb3e23151b1796690b"
    sha256 "575f52f2de45f621cb5ee9e59687bcdb5e5a82f2f8625ddb3e23151b1796690b"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:7381062358a4c6c986222939c65a7e76eb86a0c906e46d385829f152212c6384"
    sha256 "7381062358a4c6c986222939c65a7e76eb86a0c906e46d385829f152212c6384"
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
