class Home < Formula
  desc "Run your homelab from your Mac: nodes, stacks, upgrades and encrypted backups"
  homepage "https://github.com/ashishbhatiya18/home"
  url "https://github.com/ashishbhatiya18/home/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "d50615bdb2d7f23e09b9857dd7df587c75875426957acc93e82e683e5c3d6c75"
  license "MIT"
  head "https://github.com/ashishbhatiya18/home.git", branch: "main"

  depends_on "go" => :build
  depends_on "libpq" # pg_restore/psql/pg_dump for backup validation and restores

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/home"
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
