class Otelgenie < Formula
  desc "From a collector endpoint to working OpenTelemetry, guided, on your own machine"
  homepage "https://github.com/ashishbhatiya18/otelgenie"

  on_macos do
    on_arm do
      url "https://github.com/ashishbhatiya18/otelgenie/releases/download/v0.3.0/otelgenie-darwin-arm64.tar.gz"
      sha256 "caa087658eacd0e45787ed9b2fc3b3622d6e5da7470a181dc2775a86a638875e"
    end
    on_intel do
      url "https://github.com/ashishbhatiya18/otelgenie/releases/download/v0.3.0/otelgenie-darwin-amd64.tar.gz"
      sha256 "1eec41ce0e60b8ac081f08b7b74d5186a2452b54249c1bc6aed870c9def7862d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/ashishbhatiya18/otelgenie/releases/download/v0.3.0/otelgenie-linux-arm64.tar.gz"
      sha256 "0b79d1f46fc35070b726cf61a854744884b42253431d54d2fddbcf2cd4a6053b"
    end
    on_intel do
      url "https://github.com/ashishbhatiya18/otelgenie/releases/download/v0.3.0/otelgenie-linux-amd64.tar.gz"
      sha256 "93f909eb45999ad17780ed456da2be008a84b316d4e2d318ef739568ce0684b5"
    end
  end

  def install
    bin.install "otelgenie"
  end

  # Always the same address, so the page can be bookmarked.
  service do
    run [opt_bin/"otelgenie", "serve", "--addr", "127.0.0.1:11111"]
    keep_alive true
    log_path var/"log/otelgenie.log"
    error_log_path var/"log/otelgenie.log"
  end

  def caveats
    <<~EOS
      Say where your template is kept, fetch it, and keep the page running:
        otelgenie config template-url ADDRESS-OF-THE-TEMPLATE
        otelgenie update
        otelgenie install
      The page is then always at http://127.0.0.1:11111/
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/otelgenie version")
  end
end
