## opensuse 更换Aliyun镜像源
```sh
zypper mr -da
sudo zypper ar -fc https://mirrors.aliyun.com/opensuse/distribution/leap/15.2/repo/oss openSUSE15.2-Aliyun-OSS
sudo zypper ar -fc https://mirrors.aliyun.com/opensuse/distribution/leap/15.2/repo/non-oss openSUSE15.2-Aliyun-NON-OSS
sudo zypper ar -fc https://mirrors.aliyun.com/opensuse/update/leap/15.2/oss openSUSE15.2-Aliyun-UPDATE-OSS
sudo zypper ar -fc https://mirrors.aliyun.com/opensuse/update/leap/15.2/non-oss openSUSE15.2-Aliyun-UPDATE-NON-OSS
```
