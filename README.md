# Dagster Workspace

Central orchestration service for all data projects in the portfolio.
Runs continuously on Coolify — projects connect to it via gRPC.

## Architecture
- This service: webserver + daemon only
- Each project: its own Docker container, its own assets, exposes port 4000

## Adding a project
1. Deploy the project as a Coolify service (port 4000)
2. Add it to workspace.yaml:
   ```yaml
   - grpc_server:
       host: coolify-service-name
       port: 4000
       location_name: project_name
   ```
3. Restart this service

## Active projects

- **velib_lakehouse** — Vélib Paris medallion lakehouse pipeline
