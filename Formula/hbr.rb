class Hbr < Formula
  desc "Encrypted, portable, scheduled Postgres backups; restore any snapshot anywhere"
  homepage "https://github.com/ashishbhatiya18/hbr"
  url "https://github.com/ashishbhatiya18/hbr/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "5edaf54aeb8ee51d4e82cf97d3ac75aeeb6424ed436970508bc14fd1376aa242"
  license "MIT"
  head "https://github.com/ashishbhatiya18/hbr.git", branch: "main"

  depends_on "go" => :build
  depends_on "libpq" # pg_restore/psql/pg_dump for validation and restores

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -X main.version=#{version}"), "./cmd/hbr"
  end

  # Started by `hbr install` (brew services start hbr). Runs at login and every
  # 15 minutes; hbr itself decides whether the daily backup is due.
  service do
    run [opt_bin/"hbr", "run"]
    run_type :interval
    interval 900
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/opt/libpq/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    log_path var/"log/hbr.log"
    error_log_path var/"log/hbr.log"
  end

  def caveats
    <<~EOS
      Run `hbr` to set up your backups, then `hbr install` to run them
      in the background. Restore drills need Docker or Podman.
    EOS
  end

  test do
    assert_match "hbr", shell_output("#{bin}/hbr version")
  end
end
