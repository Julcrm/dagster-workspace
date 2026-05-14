FROM python:3.11-slim

WORKDIR /opt/dagster/app

# Installation de dagster webserver et daemon uniquement
# Pas de code métier ici — chaque projet a son propre Docker
RUN pip install \
    dagster \
    dagster-webserver \
    dagster-daemon

COPY workspace.yaml .

EXPOSE 3000

CMD ["dagster-webserver", "-w", "workspace.yaml", "-h", "0.0.0.0", "-p", "3000"]
