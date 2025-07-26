FROM dxflrs/garage:v2.0.0

EXPOSE 3900
EXPOSE 3901
EXPOSE 3902
EXPOSE 3903

COPY garage /var/lib/garage
COPY garage.toml /etc/garage.toml

CMD ["/garage", "server"]
