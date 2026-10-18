class HomeDeploy < Formula
  desc "home background job: deploys new node bundles with health checks and rollback"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.10.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:a3c8087fcb04b225a983c8d3995eb485853b4f8aaba8690f11e73a0906fe96dc"
    sha256 "a3c8087fcb04b225a983c8d3995eb485853b4f8aaba8690f11e73a0906fe96dc"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:4ec2d7ac2a01409c72c3edaef6f41b46aaaffd8535e5f4a1d6e6358e9f3a61c1"
    sha256 "4ec2d7ac2a01409c72c3edaef6f41b46aaaffd8535e5f4a1d6e6358e9f3a61c1"
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
