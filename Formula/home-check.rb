class HomeCheck < Formula
  desc "home background job: daily node and update check with a notification"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.1"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:5dcb7a5da8763783bd5e2602d32e9021e4f0449884318b1156f7c96f7ca0594f"
    sha256 "5dcb7a5da8763783bd5e2602d32e9021e4f0449884318b1156f7c96f7ca0594f"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:ef446688955fef52c94e1a47549b4601478d37d514ae08a5361c50ce649c3a02"
    sha256 "ef446688955fef52c94e1a47549b4601478d37d514ae08a5361c50ce649c3a02"
  end

  depends_on "ashishbhatiya18/tap/home"

  def install
    (libexec/"home-check").write <<~SH
      #!/bin/sh
      exec "#{HOMEBREW_PREFIX}/bin/home" jobs run check --if-due
    SH
    (libexec/"home-check").chmod 0755
  end

  # Started by `home install` (or `brew services start home-check`).
  service do
    run [opt_libexec/"home-check"]
    run_type :interval
    interval 900
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/opt/libpq/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    log_path var/"log/home-check.log"
    error_log_path var/"log/home-check.log"
  end

  test do
    assert_predicate libexec/"home-check", :executable?
  end
end
