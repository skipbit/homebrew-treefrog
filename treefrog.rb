class Treefrog < Formula
  desc "High-speed C++ MVC Framework for Web Application"
  homepage "http://www.treefrogframework.org/"
  # url "https://github.com/treefrogframework/treefrog-framework/archive/5e0406c1ef6408a4bba0bbed80d2effc757598e1.tar.gz"
  url "https://github.com/treefrogframework/treefrog-framework.git", :revision => "5e0406c1ef6408a4bba0bbed80d2effc757598e1"
  version "1.12.0.5e0406c"
  sha256 "01713a0d8d25219d2ddfc1083231b43248c0bb367de1ec5e8ead9d13658d4604"
  head "https://github.com/treefrogframework/treefrog-framework.git", :branch => "master"

  depends_on "homebrew/versions/qt55" => :build

  def install
    system "./configure", "--prefix=#{prefix}"

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
    true
  end
end
