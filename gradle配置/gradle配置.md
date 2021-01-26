# Gradle配置
- 下载gradle:
<br>[gradle下载](https://services.gradle.org/distributions/)
- 创建gradle安装目录，并解压:
```bash
mkdir -p ~/dev/environment/gradle
cd ~/download/
unzip [gradle文件名] -d ~/dev/environment/gradle
```
- 配置环境变量
```bash
sudo vim /etc/profile
GG 移动到底部，zz 将光标所在行移动到屏幕中央, o 另起一行进行插入。
export GRADLE_HOME=/home/insomnia/dev/environment/gradle/gradle-6.8.1
exprot PATH=$PATH:$GRADLE_HOME/bin
<Esc> ZZ(大写) 保存并退出。
source /etc/profile  刷新配置文件。
gradle -v
```
- 配置 gradle 国内镜像仓库
```bash
 进入gradle目录
 cd ~/dev/environment/gradle/gradle-6.8.1/init.d
 创建 init.gradle 文件 然后进行编辑，gradle 启动时会自动读取init.gradle 里面的配置。
 vim init.gradle
```
- 复制下面的配置到 init.gradle 。**注意: 用 gradle 构建项目之后，在 build.gradle 的 repositories 节点第一行添加 mavenLocal() 方法 使 gradle 用本地配置的 maven 仓库路径。** 
```.gradle
allprojects{
    repositories {
        def ALIYUN_REPOSITORY_URL = 'https://maven.aliyun.com/repository/public/'
        def ALIYUN_JCENTER_URL = 'https://maven.aliyun.com/repository/jcenter/'
        def ALIYUN_GOOGLE_URL = 'https://maven.aliyun.com/repository/google/'
        def ALIYUN_GRADLE_PLUGIN_URL = 'https://maven.aliyun.com/repository/gradle-plugin/'
        all { ArtifactRepository repo ->
            if(repo instanceof MavenArtifactRepository){
                def url = repo.url.toString()
                if (url.startsWith('https://repo1.maven.org/maven2/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_REPOSITORY_URL."
                    remove repo
                }
                if (url.startsWith('https://jcenter.bintray.com/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_JCENTER_URL."
                    remove repo
                }
                if (url.startsWith('https://dl.google.com/dl/android/maven2/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_GOOGLE_URL."
                    remove repo
                }
                if (url.startsWith('https://plugins.gradle.org/m2/')) {
                    project.logger.lifecycle "Repository ${repo.url} replaced by $ALIYUN_GRADLE_PLUGIN_URL."
                    remove repo
                }
            }
        }
        maven { url ALIYUN_REPOSITORY_URL }
        maven { url ALIYUN_JCENTER_URL }
        maven { url ALIYUN_GOOGLE_URL }
        maven { url ALIYUN_GRADLE_PLUGIN_URL }
    }
}
```
- gradle 构建项目需要注意的地方
- 初始化 gradle 项目之后
