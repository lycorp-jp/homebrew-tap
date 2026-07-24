class SimUse < Formula
  desc "Give AI agents eyes and hands on iOS Simulator and Android devices"
  homepage "https://github.com/lycorp-jp/sim-use"
  license "Apache-2.0"
  version "0.11.0"
  depends_on macos: :sonoma

  url "https://github.com/lycorp-jp/sim-use/releases/download/v0.11.0/sim-use-v0.11.0.tar.gz"
  sha256 "4bad411e9c05233391ad06ff35523dbaf74868f42a8005b9de6c4ff6e96f5208"

  def install
    libexec.install "sim-use", "Frameworks", "SimUse_SimUse.bundle", "SimUse_AndroidBackend.bundle"
    bin.write_exec_script libexec/"sim-use"
  end

  def post_install
    Dir.glob("#{libexec}/Frameworks/*.framework").each do |framework|
      system "codesign", "--force", "--sign", "-", "--timestamp=none", framework
    end

    system "codesign", "--force", "--sign", "-", "--timestamp=none", libexec/"sim-use"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sim-use --version")
  end
end
