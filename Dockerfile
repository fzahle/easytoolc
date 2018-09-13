FROM docker.io/scico/easybuildor:centos7

ENV EBDIR /opt/apps

ENV LMOD_VER 6.5.2
ENV EASYBUILD_PREFIX ${EBDIR}
ENV EASYBUILD_MODULES_TOOL Lmod

MAINTAINER Lars Melwyn <melwyn (at) scico.io>

USER apps
RUN module load EasyBuild
RUN git clone https://github.com/easybuilders/easybuild-easyconfigs \
  && export EASYBUILD_ROBOT_PATHS=$(pwd)/easybuild-easyconfigs/easybuild/easyconfigs \
  && eb easybuild-easyconfigs/easybuild/easyconfigs/f/foss/foss-2018b.eb easybuild-easyconfigs/easybuild/easyconfigs/p/Python/Python-2.7.15-foss-2018b.eb --robot

RUN module load Python-2.7.15-foss-2018b \
  && virtualenv py27 --system-site-packages

CMD /bin/bash
