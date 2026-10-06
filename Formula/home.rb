class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.4.0"
  license "MIT"

  on_arm do
    url "https://github.com/ashishbhatiya18/homelab/releases/download/home-cli-v0.4.0/home_darwin_arm64.tar.gz"
    sha256 "f587559d2109685c36d1c060f8ed88a7a0b4541ee483620fcfd432b932fe9cdc"
  end
  on_intel do
    url "https://github.com/ashishbhatiya18/homelab/releases/download/home-cli-v0.4.0/home_darwin_amd64.tar.gz"
    sha256 "d21bdfd49fcbb90c0e28741eed71f8e800f9f7a06756401172f9697d524a2218"
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
