class Janet < Formula
  desc "Dynamic language and bytecode vm"
  homepage "https://janet-lang.org"
  url "https://github.com/janet-lang/janet/archive/v1.8.0.tar.gz"
  sha256 "e02ae5c7b4579a23e3f30636c16d248273ed119467a076d18c9362e858eb9812"
  head "https://github.com/janet-lang/janet.git"

  bottle do
    cellar :any
    sha256 "1463083137900884332c03280ca5631a4b50b59186929a0481918dd8bcb59742" => :catalina
    sha256 "42950e446183022ad8bc3a140474ca576ba6335b069544eb91172bf1516ee812" => :mojave
    sha256 "f12854392b87f7224a3a594e122ed6762f2c04f92d714bcc36e9e50aa2d50874" => :high_sierra
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    system "meson", "setup", "build", "--buildtype=release", "--prefix=#{prefix}"
    cd "build" do
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    assert_equal "12", shell_output("#{bin}/janet -e '(print (+ 5 7))'").strip
  end
end
