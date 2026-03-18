class Inodes < Formula
  desc "CLI for the Image Nodes image processing API"
  homepage "https://imagenodes.com"
  url "https://github.com/dmt195/inodes-cli/archive/refs/tags/v0.10.tar.gz"
  sha256 "342330db5707bbe76d46adf897bd1d6e8042b3e192e5258039f718aadd079ebb"
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
