class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.11.1"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:35ab885b5985ca92d23601513f0d0342a29dd7ab5ff1de8ccf1cb17bf9753075"
    sha256 "35ab885b5985ca92d23601513f0d0342a29dd7ab5ff1de8ccf1cb17bf9753075"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:b0dc9bd6fffa148989623d73661070e2329c9830284775f4d0923de6546b61de"
    sha256 "b0dc9bd6fffa148989623d73661070e2329c9830284775f4d0923de6546b61de"
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
