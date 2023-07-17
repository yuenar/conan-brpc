from conans import ConanFile, CMake
import os

class BrpcTestConan(ConanFile):
    generators = "cmake"
    settings = "os", "os_build", "compiler", "build_type", "arch", "arch_build"
    options = {
            "shared": [True, False],
            # see the leveldb recipe in conan-leveldb/conanfile.py for why we
            # need this
            "with_snappy": [True, False] }
    default_options = {
            "shared": False,
            "with_snappy": False }

    requires = (
        'gflags/2.2.2',
        'protobuf/3.21.9',
        'leveldb/1.23',
        'openssl/1.1.1s',
        'zlib/1.2.13')


    def build(self):
        cmake = CMake(self.settings)
        cmake.configure()
        #self.run('cmake "%s" %s' % (self.conanfile_directory, cmake.command_line))
        self.run("cmake --build ." )

    def imports(self):
        self.copy("*.dll", "bin", "bin")
        self.copy("*.so", "lib", "bin")
        self.copy("*.dylib", "lib", "bin")

    def test(self):
        os.chdir("bin")
        self.run("LD_LIBRARY_PATH=$(pwd) && .%stest_package" % os.sep)
