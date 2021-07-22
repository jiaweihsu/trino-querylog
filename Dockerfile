FROM trinodb/trino

USER root

COPY --chown=trino:trino target/dependency/*.jar /usr/lib/trino/plugin/trino-querylog/
COPY --chown=trino:trino target/trino-querylog-*.jar /usr/lib/trino/plugin/trino-querylog/

COPY --chown=trino:trino event-listener.properties /etc/trino/event-listener.properties
COPY --chown=trino:trino querylog-log4j2.xml /etc/trino/querylog-log4j2.xml

RUN mkdir /var/log/trino
RUN chown -R "trino:trino" /var/log/trino

EXPOSE 8080
USER trino:trino
ENV LANG en_US.UTF-8
CMD ["/usr/lib/trino/bin/run-trino"]