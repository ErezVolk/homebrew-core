class Smimesign < Formula
  desc "S/MIME signing utility for use with Git"
  homepage "https://github.com/github/smimesign"
  url "https://github.com/github/smimesign/archive/v0.1.0.tar.gz"
  sha256 "b01443a54354c0ceab2501403b67b76e3cf2b12dcd9f0474e18a22c66099e589"
  license "MIT"

  bottle do
    cellar :any_skip_relocation
    sha256 "7c0b7b8a34d0b16789c28fb6381623b25d6f3d1e81b4b07f1c1defe930373230" => :catalina
    sha256 "c9eb62971a802249e91849385dd3ec535f163dfe0be0ce5de52d56dae08789b5" => :mojave
    sha256 "468d431ade8f15633d1ae6a9bc6b108122d8ea6ad7e99a956eff52c09ad29ba9" => :high_sierra
    sha256 "5e08213a38d69edfc45b1ffc8c2ba97ba13226f267b601648b3ed77e5b3ff12d" => :sierra
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-X main.versionString=#{version}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/smimesign --version")
    system "#{bin}/smimesign", "--list-keys"
    assert_match "could not find identity matching specified user-id: bad@identity",
      shell_output("#{bin}/smimesign -su bad@identity 2>&1", 1)
  end
end
