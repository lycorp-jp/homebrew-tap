class SimUse < Formula
  desc "Give AI agents eyes and hands on iOS Simulator and Android devices"
  homepage "https://github.com/lycorp-jp/sim-use"
  license "Apache-2.0"
  version "0.14.0"
  depends_on macos: :sonoma

  url "https://github.com/lycorp-jp/sim-use/releases/download/v0.14.0/sim-use-v0.14.0.tar.gz"
  sha256 "67e2ee29a7246272de8646e46664a93d9cebcace134094cfd3d07dfb82bda3e6"

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
