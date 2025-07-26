FROM dxflrs/garage:v2.0.0

ENV GARAGE_ADMIN_TOKEN=""
ENV GARAGE_METRICS_TOKEN=""
ENV GARAGE_RPC_SECRET=""

EXPOSE 3900
EXPOSE 3901
EXPOSE 3902
EXPOSE 3903

COPY config.toml /etc/garage/config.toml

RUN mkdir -p /garage/meta /garage/data

CMD ["garage", "server"]
