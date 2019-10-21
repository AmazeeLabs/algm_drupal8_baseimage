#!/bin/sh

if ! drush -r /app/web status --fields=bootstrap | grep -q "Successful"; then
	exit 1
fi
echo "Drupal Bootstrapped successfully"
