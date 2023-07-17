import os
from conans import ConanFile , tools ,CMake 
from conan.tools.layout import cmake_layout

class BrpcConan(ConanFile):
    name = "brpc"
    version = '1.5.0'
    license = "https://github.com/apache/incubator-brpc/blob/1.5.0/LICENSE"
    url = "https://github.com/jjkoshy/conan-recipes/conan-brpc"
    description = "An industrial-grade RPC framework used throughout Baidu"
    settings = "os", "os_build", "compiler", "build_type", "arch", "arch_build"
    
    options = {
            "shared": [True, False],
            # see the leveldb recipe in conan-leveldb/conanfile.py for why we
            # need this
            "with_snappy": [True, False] }
    default_options = {
            "shared": False,
            "with_snappy": False }
    # cmake_paths generates a file which we set as the cmake toolchain file
    #generators = ('cmake_paths', 'CMakeDeps')
    generators = ('cmake_paths', 'CMakeDeps' )
    exports_sources = ["CMakeLists.txt", "patches/*"]

    requires = (
        'gflags/2.2.2',
        'protobuf/3.21.9',
        'leveldb/1.23',
        'openssl/1.1.1s',
        'zlib/1.2.13')

    def config(self):
        # must build protobuf with zlib since brpc build does not make it optional
        self.options['protobuf'].with_zlib = True
        self.options['protobuf'].lite= True
        self.options['protobuf'].shared = self.options.shared
        self.options['leveldb'].with_snappy = self.options.with_snappy
        self.options['leveldb'].with_crc32c = self.options.with_snappy
        self.options['leveldb'].shared = self.options.shared
        self.options['gflags'].nothreads = False
        self.options['gflags'].shared = self.options.shared
        
    @property
    def zip_folder_name(self):
        return "incubator-%s-%s" % (self.name, self.version)

    def source(self):
        zip_name = "incubator-%s-%s" % (self.name, self.version)
        tools.download("https://github.com/apache/incubator-brpc/archive/%s.zip" % self.version, zip_name)
        tools.unzip(zip_name)
        # TODO: move to conandata.yml
        #tools.check_md5(zip_name, "783b3b0d5b9d254a93f26ce769b00bfc")
        os.unlink(zip_name)
        with tools.chdir("%s-%s" % (self.name, self.version)):
            # TODO: switch to conandata.yml approach
            tools.patch(patch_file="../patches/brpc-1.5.0.patch", strip=1)

            # add snappy to list of libs to link with if with_snappy is true
            if self.options.with_snappy:
                tools.patch(patch_file="../patches/snappy.patch", strip=1)

    def configure_cmake(self):
        cmake = CMake(self)

        cmake.definitions['CMAKE_TOOLCHAIN_FILE'] = 'conan_paths.cmake'
        # TODO: the source_subfolder should be something generic like
        # src or source-subfolder, and we should rename. change
        # cmakelists.txt also
        cmake.configure(
            defs={
                'CMAKE_POSITION_INDEPENDENT_CODE': True,
                'protobuf_MODULE_COMPATIBLE': True,
                'BUILD_BRPC_TOOLS': False,
            })
        return cmake
    
        
    def build(self):
        cmake = self.configure_cmake()
        cmake.build()
        self.run("cmake --build .")
        
        
    def cmake_configure(self):
        if self.settings.os == "Linux":
            self.run("cmake --preset=linux .")
        elif self.settings.os == "Macos":
            self.run("cmake --preset=macos .")
        elif self.settings.os == "Windows":
            self.run("cmake --preset=windows .")
        else:
            raise ConanInvalidConfiguration("Unsupported OS")
            
    def package(self):
        self.copy("LICENSE", "brpc-1.5.0", keep_path=False)
        cmake = self.configure_cmake()
        cmake.install()

    def package_info(self):
        self.cpp_info.libs = ["brpc"]
        if self.settings.os == "Linux":
            self.cpp_info.libs.append("pthread")

