require "formula"

class Pfshdrcreate < Formula
  homepage "http://sourceforge.net/p/qtpfsgui/pfshdrcreate/ci/master/tree/"
  url "git://git.code.sf.net/p/qtpfsgui/pfshdrcreate"
  version "11-29-2006"
  sha1 ""

  depends_on :automake
  depends_on :autoconf
  depends_on 'libtool' => :build

  depends_on "pkg-config" => :build
  depends_on "pfscalibration"

  def install
    system "glibtoolize --force"
    system "rm -f config.cache"
    system "aclocal"
    system "autoconf"
    system "autoheader"
    system "echo 'dummy' > COPYING"
    system "automake --add-missing"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

  def patches
    # This patch removes errorneous entries from the cmake system
    DATA
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test pfshdrcreate`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

__END__

diff --git a/configure.ac b/configure.ac
index 0fea935..5ea9825 100644
--- a/configure.ac
+++ b/configure.ac
@@ -13,7 +13,7 @@ AC_PROG_LIBTOOL
 dnl
 dnl Default setup
 dnl
-CXXFLAGS="-O3 -funroll-loops -fstrength-reduce -fschedule-insns2 -felide-constructors -frerun-loop-opt -fexceptions -fno-strict-aliasing -fexpensive-optimizations -ffast-math -pipe"
+CXXFLAGS="-O3 -funroll-loops -fstrength-reduce -felide-constructors -frerun-loop-opt -fexceptions -fno-strict-aliasing -fexpensive-optimizations -ffast-math -pipe"
 
 dnl
 dnl Templates for autoheader defines
diff --git a/src/Makefile.am b/src/Makefile.am
index 8452937..185fc78 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -1,14 +1,13 @@
 ###
 bin_PROGRAMS = pfshdrcreate
-bin_SCRIPTS  = jpeg2hdrgen pfsinhdrgen
 
 pfshdrcreate_SOURCES = pfshdrcreate.cpp \
 			  responses.cpp responses.h \
 			  robertson02.cpp robertson02.h \
 			  icip06.cpp icip06.h
 
-man_MANS =  jpeg2hdrgen.1 pfsinhdrgen.1 pfshdrcreate.1
+man_MANS =  pfshdrcreate.1
 
 LIBS = $(PFS_LIBS) -lm
 INCLUDES = $(PFS_CFLAGS)
-EXTRA_DIST = $(man_MANS) $(bin_SCRIPTS)
+EXTRA_DIST = $(man_MANS) 

