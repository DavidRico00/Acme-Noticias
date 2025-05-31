FROM tonitoro/glassfish-acme-app

USER root
RUN apt-get update && apt-get install -y default-mysql-client && rm -rf /var/lib/apt/lists/*
USER glassfish

COPY --chmod=755 wait-for-mysql.sh /wait-for-mysql.sh

ENTRYPOINT ["/wait-for-mysql.sh", "acmedb", "3306", "root", "acme", "40", "/opt/glassfish7/bin/asadmin", "start-domain", "--verbose"]
