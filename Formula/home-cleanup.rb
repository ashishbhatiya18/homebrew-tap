class HomeCleanup < Formula
  desc "home background job: daily pruning of unused images and caches on every node"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.4"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:7a224bf801bb62085e70ce955973e912979503b4cba3cdecb234e69d956dc4e5"
    sha256 "7a224bf801bb62085e70ce955973e912979503b4cba3cdecb234e69d956dc4e5"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:1725229cca6d1a12f0e116fce5a133b79ceed35941635e3f9c7f685b3e110f04"
    sha256 "1725229cca6d1a12f0e116fce5a133b79ceed35941635e3f9c7f685b3e110f04"
  end

  depends_on "ashishbhatiya18/tap/home"

  def install
    (libexec/"home-cleanup").write <<~SH
      #!/bin/sh
      exec "#{HOMEBREW_PREFIX}/bin/home" jobs run cleanup --if-due
    SH
    (libexec/"home-cleanup").chmod 0755
  end

  # Started by `home install` (or `brew services start home-cleanup`).
  service do
    run [opt_libexec/"home-cleanup"]
    run_type :interval
    interval 3600
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/opt/libpq/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    log_path var/"log/home-cleanup.log"
    error_log_path var/"log/home-cleanup.log"
  end

  test do
    assert_predicate libexec/"home-cleanup", :executable?
  end
end
