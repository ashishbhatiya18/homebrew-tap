class HomeDeploy < Formula
  desc "home background job: deploys new node bundles with health checks and rollback"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.12.3"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:9d82da39c3571fcb00111259424c493a1e003968bbfb2de4a6a0df2ab2e4107f"
    sha256 "9d82da39c3571fcb00111259424c493a1e003968bbfb2de4a6a0df2ab2e4107f"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:be3b9700b0d553182f01cbecb5097a4d498f2b9b20e15b911373814ca4cebf73"
    sha256 "be3b9700b0d553182f01cbecb5097a4d498f2b9b20e15b911373814ca4cebf73"
  end

  depends_on "ashishbhatiya18/tap/home"

  def install
    (libexec/"home-deploy").write <<~SH
      #!/bin/sh
      exec "#{HOMEBREW_PREFIX}/bin/home" jobs run deploy --if-due
    SH
    (libexec/"home-deploy").chmod 0755
  end

  # Started by `home install` (or `brew services start home-deploy`).
  service do
    run [opt_libexec/"home-deploy"]
    run_type :interval
    interval 300
    environment_variables PATH: "#{HOMEBREW_PREFIX}/bin:#{HOMEBREW_PREFIX}/opt/libpq/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    log_path var/"log/home-deploy.log"
    error_log_path var/"log/home-deploy.log"
  end

  test do
    assert_predicate libexec/"home-deploy", :executable?
  end
end
