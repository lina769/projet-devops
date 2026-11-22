# Projet DevOps : pipeline CI/CD

Pipeline CI/CD autour d'une application, avec Git/GitHub, Jenkins et Docker.

## Workflow Git

- `main` : version stable, protégée (pas de push direct)
- `dev` : branche de développement
- `feature/<prénom>-<sujet>` : une branche par tâche
- Toute modification passe par une Pull Request vers `dev`, relue par un autre membre
- Versions : tags `vX.Y.Z` (exemple : `v1.0.0`), créés depuis `main`

## Pipelines Jenkins

| Pipeline        | Déclencheur             | Fichier               |
| --------------- | ----------------------- | --------------------- |
| Build & Smoke   | Pull Request vers `dev` | `Jenkinsfile.pr`      |
| Build complet   | Push sur `dev`          | `Jenkinsfile.dev`     |
| Build versionné | Tag `vX.Y.Z`            | `Jenkinsfile.release` |

## Structure du dépôt

- `app/` : l'application
- `Dockerfile` : construction de l'image
- `Makefile` : commandes `build`, `run`, `smoke`, `clean`
- `scripts/smoke.sh` : smoke test (code 0 = Passed, 1 = Failed)
- `jenkins/` : installation de Jenkins
- `docs/` : documentation

## Smoke test

`sh scripts/smoke.sh [url]` vérifie `/health` et `/`. Le résultat est écrit dans `reports/smoke-results.txt`.
