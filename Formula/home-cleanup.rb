class HomeCleanup < Formula
  desc "home background job: daily pruning of unused images and caches on every node"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:3e4e6931f2f4cde9604b874193ac9cb5f440f314c0198469f3b32866df5998f9"
    sha256 "3e4e6931f2f4cde9604b874193ac9cb5f440f314c0198469f3b32866df5998f9"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:62e9cfc05e7929325193b60b0a63a4ad780588b00046328015f4b878203f9770"
    sha256 "62e9cfc05e7929325193b60b0a63a4ad780588b00046328015f4b878203f9770"
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
