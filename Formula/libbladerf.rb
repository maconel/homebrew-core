class Libbladerf < Formula
  desc "USB 3.0 Superspeed Software Defined Radio Source"
  homepage "https://nuand.com/"
  url "https://github.com/Nuand/bladeRF.git",
    :tag      => "2019.07",
    :revision => "991bba2f9c4d000f000077cc465878d303417e26"
  head "https://github.com/Nuand/bladeRF.git"

  bottle do
    rebuild 1
    sha256 "00cb383f943dc5b44b96b3e55c89cad7453555f15ab1a75542d29fbb6c0ab864" => :catalina
    sha256 "546b18f2b500dcc1a9b3d28082623403e4f1fd76cdfb142bec2d42dcb028c51f" => :mojave
    sha256 "c54412e09190dfb73db598b925eb6cc49858f84aabea022f16f963d34e935b8c" => :high_sierra
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    ENV.prepend "CFLAGS", "-I#{MacOS.sdk_path}/usr/include/malloc"
    mkdir "host/build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system bin/"bladeRF-cli", "--version"
  end
end
