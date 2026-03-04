# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Contratos SaaS is a contract management SaaS application built with Rails 8.1.1, Ruby 3.4.5, and PostgreSQL. It is a freshly scaffolded project following Rails 8 omakase conventions, ready for feature development.

## Common Commands

### Development
- `bin/dev` — Start development server (Rails + Tailwind CSS watch via Foreman)
- `bin/rails server` — Start Rails server only
- `bin/rails tailwindcss:watch` — Watch and rebuild Tailwind CSS

### Testing
- `bin/rails test` — Run all unit/integration tests
- `bin/rails test test/models/user_test.rb` — Run a single test file
- `bin/rails test test/models/user_test.rb:42` — Run a single test by line number
- `bin/rails test:system` — Run system tests (Capybara + headless Chrome)
- `bin/rails db:test:prepare` — Prepare test database before running tests

### Linting & Security
- `bin/rubocop` — Lint Ruby code (Omakase style)
- `bin/rubocop -a` — Auto-fix lint violations
- `bin/brakeman --no-pager` — Static security analysis
- `bin/bundler-audit` — Scan gems for vulnerabilities
- `bin/importmap audit` — Scan JavaScript dependencies

### Database
- `bin/rails db:create` — Create databases
- `bin/rails db:migrate` — Run migrations
- `bin/rails db:seed` — Seed database

### Background Jobs
- `bin/jobs` — Run Solid Queue job worker

## Architecture

### Tech Stack
- **Backend**: Rails 8.1.1, Ruby 3.4.5, PostgreSQL
- **Frontend**: Hotwire (Turbo + Stimulus), Tailwind CSS, Import Maps, Propshaft
- **Background Jobs**: Solid Queue (database-backed, replaces Redis/Sidekiq)
- **Caching**: Solid Cache (database-backed)
- **WebSockets**: Solid Cable (database-backed)
- **Deployment**: Kamal with Docker (multi-stage build)

### Multi-Database Setup (Production)
The app uses four PostgreSQL databases in production:
- **primary** — Application data (`db/migrate`)
- **cache** — Solid Cache (`db/cache_migrate`)
- **queue** — Solid Queue (`db/queue_migrate`)
- **cable** — Solid Cable (`db/cable_migrate`)

Development and test use a single database each.

### Code Style
Uses `rubocop-rails-omakase` — the Rails team's default style guide. No custom overrides.

### Testing
- Framework: Minitest with parallel execution
- System tests: Capybara + Selenium (headless Chrome)
- Fixtures loaded automatically from `test/fixtures/`
- CI runs: Brakeman, Bundler Audit, Importmap Audit, RuboCop, unit tests, system tests

### Deployment
- Kamal deploys to Docker containers
- Solid Queue runs in-process via Puma (`SOLID_QUEUE_IN_PUMA=true`) on single-server setup
- Thruster handles HTTP asset caching/compression in front of Puma
- Production runs as non-root `rails` user (UID 1000)
