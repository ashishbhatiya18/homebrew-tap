class HomeBackup < Formula
  desc "home background job: encrypted backups (home br) when due"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.5"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:84299aa25517651d9922559f96d22f033a6925ea3161381e03653ff0efd8d482"
    sha256 "84299aa25517651d9922559f96d22f033a6925ea3161381e03653ff0efd8d482"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:63dc16614a2b4e886cedfa957000ca50f0331e5f258521bff5266ccbd1eccb4f"
    sha256 "63dc16614a2b4e886cedfa957000ca50f0331e5f258521bff5266ccbd1eccb4f"
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
