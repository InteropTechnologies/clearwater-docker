FROM clearwater/base
MAINTAINER maintainers@projectclearwater.org

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes homestead
RUN sed -e 's/\(echo 0 > \/proc\/sys\/kernel\/yama\/ptrace_scope\)/# \1/g' -i /etc/init.d/homestead

COPY generic_create_diameterconf.patch /tmp/generic_create_diameterconf.patch
RUN cd /usr/share/clearwater
RUN patch /usr/share/clearwater/bin/generic_create_diameterconf /tmp/generic_create_diameterconf.patch
COPY homestead-script.patch /tmp/homestead-script.patch
RUN cd /usr/share/clearwater
RUN patch /usr/share/clearwater/infrastructure/scripts/homestead /tmp/homestead-script.patch

COPY homestead.supervisord.conf /etc/supervisor/conf.d/homestead.conf
COPY nginx.supervisord.conf /etc/supervisor/conf.d/nginx.conf
COPY clearwater-group.supervisord.conf /etc/supervisor/conf.d/clearwater-group.conf

# We need to start the socket factories so that we can write to SAS.
RUN cp /etc/clearwater/socket-factory.supervisord.conf /etc/supervisor/conf.d/

EXPOSE 8888
