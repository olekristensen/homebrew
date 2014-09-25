require "formula"

class Pfscalibration < Formula
  homepage "http://pfstools.sourceforge.net/pfscalibration.html"
  url "https://downloads.sourceforge.net/project/pfstools/pfscalibration/1.6/pfscalibration-1.6.tar.gz"
  sha1 "ab079079b827fb6d6e7a8fdede1fd10812a8ec6b"

  depends_on "pfstools"
  depends_on "pkg-config" => :build
  depends_on "gnuplot"
  depends_on "libexif"
  depends_on "homebrew/science/opencv"

  def install
    # g++ specific compiler flags are useless to us
    inreplace "configure", "-fschedule-insns2 ", ""
    # Remove unrecognized options if warned by configure
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    system "#{bin}/pfshdrcalibrate -h"
  end
end
