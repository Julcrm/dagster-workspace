FROM python:3.11-slim

WORKDIR /opt/dagster/app

# Mise à jour pip avant installation
RUN pip install --upgrade pip

# Installation en une seule commande pour que pip résoud les dépendances ensemble
RUN pip install --no-cache-dir dagster dagster-webserver dagster-daemon

COPY workspace.yaml .

EXPOSE 3000

CMD ["dagster-webserver", "-w", "workspace.yaml", "-h", "0.0.0.0", "-p", "3000"]