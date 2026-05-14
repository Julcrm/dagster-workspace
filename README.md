# Dagster Workspace

Service central d'orchestration pour tous les projets data du portfolio.
Tourne en permanence sur Coolify — les projets s'y connectent via gRPC.

## Architecture
- Ce service : webserver + daemon uniquement
- Chaque projet : son propre Docker, ses propres assets, expose le port 4000

## Ajouter un projet
1. Déployer le projet comme service Coolify (port 4000)
2. Ajouter dans workspace.yaml :
   ```yaml
   - grpc_server:
       host: nom-du-service-coolify
       port: 4000
       location_name: nom_projet
   ```
3. Redémarrer ce service

## Projets actifs

- **velib_lakehouse** — Pipeline lakehouse medallion Vélib Paris
