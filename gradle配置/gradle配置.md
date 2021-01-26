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
<br> 初始化 gradle 项目之后，需要修改项目目录下 gradle 文件夹下 wrapper/gradle-wrapper.properties 文件 **distributionUrl** 的指向。
```properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
#修改成本地 gradle.zip 路径
distributionUrl=file:/home/insomnia/dev/environment/gradle/gradle-6.7-bin.zip 
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
```
- gradle 初始化 java 项目 build.gradle 文件:
```.gradle
plugins {
    id 'java'
}

group 'com.insomnia'
version '1.0.1'

repositories {
 // mavenLocal() 一定要放在地一行。
    mavenLocal()
    mavenCentral()
}

dependencies {
 // 添加spring-mvc 依赖 测试下载速度。
    compile group: 'org.springframework', name: 'spring-webmvc', version: '5.2.0.RELEASE'
    testImplementation 'org.junit.jupiter:junit-jupiter-api:5.6.0'
    testRuntimeOnly 'org.junit.jupiter:junit-jupiter-engine'
}

test {
    useJUnitPlatform()
}
```
