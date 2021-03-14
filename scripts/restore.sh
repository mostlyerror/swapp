#!/usr/bin/env bash
pg_restore --verbose --clean --no-acl --no-owner -h localhost -d swapp_development prod.dump
