FROM registry.access.redhat.com/ubi8/python-39:1-48

ENV APP_SCRIPT=/opt/app-root/bin/start.sh \
    DATA_ROOT=/opt/app-root/data \
    JUPYTER_LAB_VERSION=3.4.0 \
    JUPYTER_CMD=notebook

USER root

RUN mkdir -p ${DATA_ROOT}
RUN chown -R 1001:0 ${DATA_ROOT} && \
    fix-permissions ${DATA_ROOT} -P

RUN pip install jupyterlab==${JUPYTER_LAB_VERSION}

RUN jupyter notebook --generate-config && \
    npm cache clean --force && \
    jupyter lab clean

RUN chown -R 1001:0 ${APP_ROOT} && \
    fix-permissions ${APP_ROOT} -P && \
    rpm-file-permissions

# the default start script, can be changed by setting APP_SCRIPT
COPY start.sh /opt/app-root/bin/start.sh
RUN chmod +x /opt/app-root/bin/start.sh && \
    chown default:root /opt/app-root/bin/start.sh
ENV APP_SCRIPT=/opt/app-root/bin/start.sh

USER 1001
