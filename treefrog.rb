class Treefrog < Formula
  desc "High-speed C++ MVC Framework for Web Application"
  homepage "http://www.treefrogframework.org/"
  url "https://github.com/treefrogframework/treefrog-framework.git", :tag => "v1.13.0", :revision => "dad8d4bbb4ae0bfb480352fde3ba5dd1321ccff8"
  head "https://github.com/treefrogframework/treefrog-framework.git", :branch => "master"

  option "with-debug", "build with debug information"
  option "with-gui", "build and link with QtGui module"
  option "with-mongo", "build with MongoDB driver library"
  option "with-mysql", "enable --with-mysql option for Qt build"
  option "with-oci", "enable --with-oci option for Qt build"

  depends_on MinimumMacOSRequirement => :el_capitan
  depends_on XcodeRequirement => [:build, :version => ">= 8.0"]

  qtopts = ["with-postgresql"]
  qtopts << "with-oci" if build.with?("oci") && ENV["ORACLE_HOME"]
  qtopts << "with-mysql" if build.with? "mysql"
  depends_on "qt5" => qtopts

  def install
    args = ["--prefix=#{prefix}"]

    if build.with? "debug"
      args << "--enable-debug"
    end

    if build.with? "gui"
      args << "--enable-gui-mod"
    end

    if build.with? "mongo"
      args << "--enable-mongo"
    end

    system "./configure", *args

    cd "src" do
      system "make"
      system "make", "install"
    end

    cd "tools" do
      system "make"
      system "make", "install"
    end
  end

  test do
    cd testpath do
      system "tspawn", "new", "hello"
      assert File.exist?("hello")
      cd "hello" do
        assert File.exist?("hello.pro")
        system "qmake"
        assert File.exist?("Makefile")
        system "make"
        system "treefrog", "-d", "-e", "dev"
        system "treefrog", "-k", "stop"
      end
    end
  end
end
