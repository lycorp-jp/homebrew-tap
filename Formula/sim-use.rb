class SimUse < Formula
  desc "Give AI agents eyes and hands on iOS Simulator and Android devices"
  homepage "https://github.com/lycorp-jp/sim-use"
  license "Apache-2.0"
  version "0.13.0"
  depends_on macos: :sonoma

  url "https://github.com/lycorp-jp/sim-use/releases/download/v0.13.0/sim-use-v0.13.0.tar.gz"
  sha256 "f3da237663199faf4c7f6796c3ede6ce7583da872dc27d92eb3b7eb051725081"

  def install
    libexec.install "sim-use", "SimUse_SimUse.bundle", "SimUse_AndroidBackend.bundle"
    bin.write_exec_script libexec/"sim-use"
  end

  def post_install
    system "codesign", "--force", "--sign", "-", "--timestamp=none", libexec/"sim-use"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sim-use --version")
  end
end
