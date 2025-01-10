#!/usr/bin/env python

import fire
import os
import requests
import yaml
from datetime import datetime


def createdAfter(created_date_str, after_date):
    if after_date is None:
        return True

    created_date_str = created_date_str.split('Z')[0]
    if '.' in created_date_str:
        # Truncate to microseconds (6 decimal places)
        created_date_str = created_date_str[:26]
    created_date = datetime.strptime(
        created_date_str, "%Y-%m-%dT%H:%M:%S.%f" if '.' in created_date_str else "%Y-%m-%dT%H:%M:%S")
    try:
        after_date_obj = datetime.strptime(after_date, "%Y-%m-%d")
    except ValueError:
        try:
            after_date_obj = datetime.strptime(after_date, "%Y-%m")
        except ValueError:
            after_date_obj = datetime.strptime(after_date, "%Y")

    return created_date > after_date_obj

# 从给定的一个repo地址下载所有chart的tgz文件到指定地址


def download_charts(repo_url, local_path, since=None, limit=None):
    if not os.path.exists(local_path):
        os.makedirs(local_path)

    index_url = os.path.join(repo_url, 'index.yaml')
    response = requests.get(index_url)
    if response.status_code != 200:
        raise Exception(f"Failed to fetch index.yaml from {index_url}")

    index_data = yaml.safe_load(response.text)
    charts = index_data.get('entries', {})

    # Create a flat list of all versions with their chart names
    all_versions = []
    for chart_name, versions in charts.items():
        for version in versions:
            if createdAfter(version["created"], since):
                all_versions.append((chart_name, version))

    # Sort by creation date, newest first
    all_versions.sort(key=lambda x: x[1]["created"], reverse=True)

    # Limit to recent_count if specified
    if limit is not None:
        all_versions = all_versions[:int(limit)]

    total_charts = len(all_versions)
    for index, (chart_name, version) in enumerate(all_versions, 1):
        chart_url = version['urls'][0]
        full_chart_url = os.path.join(
            repo_url, chart_url) if not chart_url.startswith('http') else chart_url
        print(
            f"↓ Downloading [{index}/{total_charts}] {chart_name}:{version['version']}")

        chart_response = requests.get(full_chart_url)
        if chart_response.status_code == 200:
            chart_filename = os.path.join(
                local_path, os.path.basename(chart_url))
            with open(chart_filename, 'wb') as f:
                f.write(chart_response.content)
            print(f"✓ Downloaded {chart_filename}")
        else:
            print(f"✗ Failed to download {chart_url}")


if __name__ == '__main__':
    fire.Fire(download_charts)
