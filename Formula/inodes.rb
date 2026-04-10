class Inodes < Formula
  desc "CLI for the Image Nodes image processing API"
  homepage "https://imagenodes.com"
  url "https://github.com/dmt195/inodes-cli/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c41f1eca9b24cebc765a7ddb2f2785fadc3860d8db4e0addcdb618e09d81d71d"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags)
    system "go", "build", "-ldflags", ldflags, "-o", bin/"inodes-mcp-server", "./cmd/mcp-server"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/inodes --version")
    assert_match "imagenodes", shell_output("#{bin}/inodes-mcp-server --help 2>&1", 0)
  end
end
