class HomeBackup < Formula
  desc "home background job: encrypted backups (home br) when due"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.6.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:224e683a6674d6daf7d74001d1d7d8fadf9165816e16d4b85caef576cc6f4953"
    sha256 "224e683a6674d6daf7d74001d1d7d8fadf9165816e16d4b85caef576cc6f4953"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:743750400e0b1d18c0ac39ba15639932580388c0462bd5ffbd4782ffbe7fdd76"
    sha256 "743750400e0b1d18c0ac39ba15639932580388c0462bd5ffbd4782ffbe7fdd76"
  end

  depends_on "ashishbhatiya18/tap/home"

  def install
    (libexec/"home-backup").write <<~SH
      #!/bin/sh
      exec "#{HOMEBREW_PREFIX}/bin/home" jobs run backup --if-due
    SH
    (libexec/"home-backup").chmod 0755
  end

  # Started by `home install` (or `brew services start home-backup`).
  service do
    run [opt_libexec/"home-backup"]
    run_type :interval
    interval 900
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/opt/libpq/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    log_path var/"log/home-backup.log"
    error_log_path var/"log/home-backup.log"
  end

  test do
    assert_predicate libexec/"home-backup", :executable?
  end
end
