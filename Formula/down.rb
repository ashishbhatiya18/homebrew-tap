class Down < Formula
  desc "Download magnet links, torrents, YouTube and URLs, then clean up the leftovers"
  homepage "https://github.com/ashishbhatiya18/homelab/tree/main/down-cli"
  version "0.1.1"
  license "MIT"

  on_arm do
    url "https://ghcr.io/v2/ashishbhatiya18/down-cli/blobs/sha256:5a6524946f04d22d040ab0af7d4bf6286e00e231e468522e4ab7d636a6bd6c32"
    sha256 "5a6524946f04d22d040ab0af7d4bf6286e00e231e468522e4ab7d636a6bd6c32"
  end
  on_intel do
    url "https://ghcr.io/v2/ashishbhatiya18/down-cli/blobs/sha256:d2f281a27c8983d22515b9c7cef6ad9914dc261439288f2398be61d2c6fccfd4"
    sha256 "d2f281a27c8983d22515b9c7cef6ad9914dc261439288f2398be61d2c6fccfd4"
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
