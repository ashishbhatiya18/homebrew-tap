class Down < Formula
  desc "Download magnet links, torrents, YouTube and URLs, then clean up the leftovers"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/down-cli"
  version "0.1.0"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/down-cli/blobs/sha256:82d4374afc07b1a458b723493a6242b7c23cf12156158119cf6e74183a422a6c"
    sha256 "82d4374afc07b1a458b723493a6242b7c23cf12156158119cf6e74183a422a6c"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/down-cli/blobs/sha256:fbb48f50c1c17ec52288038ef4130e68e0ff6c892e14baacaec486adb077c0ca"
    sha256 "fbb48f50c1c17ec52288038ef4130e68e0ff6c892e14baacaec486adb077c0ca"
  end

  depends_on "aria2"   # torrents and direct downloads
  depends_on "deno"    # JS runtime yt-dlp needs for YouTube
  depends_on "ffmpeg"  # audio extraction, merging, embedding
  depends_on "sevenzip" # unpacking rar/7z, multi-part included
  depends_on "yt-dlp"

  def install
    bin.install "down"
  end

  test do
    assert_match "down", shell_output("#{bin}/down version")
  end
end
