# GitHub Actions CI/CD

## Concepts
- **Workflow**: A configurable automated process made up of one or more jobs.
- **Job**: A set of steps that execute on the same runner.
- **Step**: An individual task that can run commands or actions.
- **Runner**: A server that runs your workflows when triggered.

## Workflows in this Project

### 1. Linting Workflow
- **File**: `.github/workflows/linting.yml`
- **Triggers**: Push to main, Pull Requests to main, Manual trigger
- **Jobs**:
  - **lint**: Runs code quality checks using Black and pre-commit

### 2. Build, Test, and Deploy Workflow
- **File**: `.github/workflows/build-test-deploy.yml`
- **Triggers**: Push to main, Pull Requests to main, Manual trigger
- **Jobs**:
  - **build**: Builds the Docker image using Docker Buildx
  - **test**: Runs Django tests with PostgreSQL and Redis services
  - **deploy**: (Commented out) Template for future deployment

## Setting Up Secrets
For the workflows to function properly, you may need to set up the following secrets in your GitHub repository:

1. `DJANGO_SECRET_KEY`: Your Django secret key for production
2. For deployment (when uncommented):
   - `SSH_HOST`: The hostname of your server
   - `SSH_USERNAME`: The username for SSH access
   - `SSH_PRIVATE_KEY`: The private key for SSH access

## Local Development
You can use pre-commit hooks locally to ensure your code passes the same checks that run in CI:

```bash
pip install pre-commit
pre-commit install
```
