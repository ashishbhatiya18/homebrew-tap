class HomeDeploy < Formula
  desc "home background job: deploys new node bundles with health checks and rollback"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/home-cli"
  version "0.11.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:56391014ed35f1d234a4747395bd2fa598650094f854cb0e2377d3cb0a5ad460"
    sha256 "56391014ed35f1d234a4747395bd2fa598650094f854cb0e2377d3cb0a5ad460"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/home-cli/blobs/sha256:87ce3696b2cb97ba12fd70bd79a2987aa271093582396853af731432cdb2166d"
    sha256 "87ce3696b2cb97ba12fd70bd79a2987aa271093582396853af731432cdb2166d"
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
