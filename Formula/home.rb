class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.4.2"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:9645c66d8bd6aee7fea60078d8ccb08b1476c564a8514b4f2c3da47a1a3dbced"
    sha256 "9645c66d8bd6aee7fea60078d8ccb08b1476c564a8514b4f2c3da47a1a3dbced"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:e9577d13dd887f22b2ce8b3054967d97b73b2aff07cbd844d311d0145d55b83b"
    sha256 "e9577d13dd887f22b2ce8b3054967d97b73b2aff07cbd844d311d0145d55b83b"
  end

  depends_on "libpq" # pg_restore/psql/pg_dump for backup validation and restores

  def install
    bin.install "home"
  end

  # Started by `home install`. Runs at login and every 15 minutes; home decides
  # whether the daily backups and the daily node check are due.
  service do
    run [opt_bin/"home", "run"]
    run_type :interval
    interval 900
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/opt/libpq/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    log_path var/"log/home.log"
    error_log_path var/"log/home.log"
  end

  def caveats
    <<~EOS
      Run `home` to set up your nodes and `home br setup` for backups, then
      `home install` to run daily backups and node checks in the background.
      Coming from hbr? `home br` picks up your hbr settings automatically.
    EOS
  end

  test do
    assert_match "home", shell_output("#{bin}/home version")
  end
end
