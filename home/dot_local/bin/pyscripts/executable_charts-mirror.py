#!/usr/bin/env python

import yaml
import subprocess
import os


def main():
    with open('mirror.yaml', 'r') as f:
        config = yaml.safe_load(f)

    target = config['target']
    charts = config['charts']

    for chart in charts:
        name = chart['name']
        url = chart['url']
        since = chart.get('since')
        limit = chart.get('limit')
        local_path = f'charts/{name}'

        # Download charts
        download_command = [
            'python', './scripts/charts-pull.py', url, local_path]
        if since:
            download_command += ["--since", since]
        if limit:
            download_command += ["--limit", str(limit)]
        print(f"Running: {' '.join(download_command)}")
        subprocess.run(download_command, check=True)

        # Upload charts
        remote = target
        if target.startswith("oci://") or target.startswith("http"):
            remote = "{}/{}".format(target, name)
        
        upload_command = [
            'python', './scripts/charts-push.py', local_path, remote]
        print(f"Running: {' '.join(upload_command)}")
        subprocess.run(upload_command, check=True)


if __name__ == '__main__':
    main()
