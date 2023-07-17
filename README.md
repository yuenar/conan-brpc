# conan-brpc
conan package for brpc/brpc


conan编译创建包
	交叉编译需要根据自身环境修改配置文件　cross_aarch64.profile文件需要放到~/.conan/profiles/cross_aarch64.profile 

打开终端输入,记得终端需要走代理！！!\
	
	export CONAN_DISABLE_STRICT_MODE=1

	conan create conan-brpc brpc/1.5.0@btsh/release --build=missing -s build_type=Release --test-folder=None
	

创建交叉编译版本

	conan create conan-brpc brpc/1.5.0@btsh/aarch64_rel --build=missing -s build_type=Release --test-folder=None -pr:h=cross_aarch64.profile -pr:b=default



使用交叉编译版本

	conan install conanfile_aarch64.txt 	--build=missing -s build_type=Release -pr:h=cross_aarch64.profile -pr:b=default

 用vscode 进行编译调试

在运行编译之前在有conanfile.txt文件目录，cycas项目需要cd到ncservice目录下打开终端输入
	
	conan install . --build=missing -s build_type=Debug

或者XX.txt版本

	conan install conanfile_x64.txt --build=missing -s build_type=Release
	
	conan install conanfile_X86.txt --build=missing -s build_type=Debug
