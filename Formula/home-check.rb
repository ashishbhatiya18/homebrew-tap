class HomeCheck < Formula
  desc "home background job: daily node and update check with a notification"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.8.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:5b216e161ff81e2dce026317d636bf05900ab4c06fbd70b7263b04cc6ef0a370"
    sha256 "5b216e161ff81e2dce026317d636bf05900ab4c06fbd70b7263b04cc6ef0a370"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:455ced80a85eb197690af43892f4d2c9a246c2ab7d12412d99b2cd906a91b5a6"
    sha256 "455ced80a85eb197690af43892f4d2c9a246c2ab7d12412d99b2cd906a91b5a6"
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
