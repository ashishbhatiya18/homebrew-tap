class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.4.1"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:785bc922780b4f27d2658b743d5952ff81c3971135ce1b8bed5d5e3decf45bd2"
    sha256 "785bc922780b4f27d2658b743d5952ff81c3971135ce1b8bed5d5e3decf45bd2"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:29471be4bb6defc9c0fdae6e57b0e3c0a35ef20b4ba04aedea355542d19cd819"
    sha256 "29471be4bb6defc9c0fdae6e57b0e3c0a35ef20b4ba04aedea355542d19cd819"
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
