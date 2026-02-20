#!/usr/bin/env python3
"""Rutracker.org CLI: login, search, and download torrents."""

import argparse
import os
import sys
from html import unescape
from pathlib import Path

import requests
from bs4 import BeautifulSoup

BASE_URL = "https://rutracker.org/forum"
LOGIN_URL = f"{BASE_URL}/login.php"
SEARCH_URL = f"{BASE_URL}/tracker.php"
DOWNLOAD_URL = f"{BASE_URL}/dl.php"
TOPIC_URL = f"{BASE_URL}/viewtopic.php"


def get_credentials():
    user = os.environ.get("RUTRACKER_USER")
    password = os.environ.get("RUTRACKER_PASS")
    if not user or not password:
        print(
            "Error: RUTRACKER_USER and RUTRACKER_PASS environment variables required",
            file=sys.stderr,
        )
        sys.exit(1)
    return user, password


def create_session():
    session = requests.Session()
    session.headers.update(
        {
            "User-Agent": "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0"
        }
    )
    return session


def login(session):
    user, password = get_credentials()
    resp = session.post(
        LOGIN_URL,
        data={
            "login_username": user,
            "login_password": password,
            "login": "Вход",
        },
    )
    resp.raise_for_status()
    if "bb_session" not in session.cookies.get_dict():
        print("Login failed: no session cookie received", file=sys.stderr)
        sys.exit(1)


def cmd_login(_args):
    session = create_session()
    login(session)
    print("Login successful")


def format_size(size_bytes):
    if size_bytes >= 1024**3:
        return f"{size_bytes / 1024**3:.1f} GB"
    if size_bytes >= 1024**2:
        return f"{size_bytes / 1024**2:.0f} MB"
    return f"{size_bytes / 1024:.0f} KB"


def parse_size(text):
    """Parse size text like '1.5 GB' or '700 MB' into bytes."""
    text = text.strip().replace("\xa0", " ")
    parts = text.split()
    if len(parts) != 2:
        return 0
    try:
        value = float(parts[0])
    except ValueError:
        return 0
    unit = parts[1].upper()
    multipliers = {"B": 1, "KB": 1024, "MB": 1024**2, "GB": 1024**3, "TB": 1024**4}
    return int(value * multipliers.get(unit, 1))


def cmd_search(args):
    session = create_session()
    login(session)

    resp = session.get(
        SEARCH_URL,
        params={
            "nm": args.query,
            "o": "10",  # sort by seeds
            "s": "2",  # descending
        },
    )
    resp.raise_for_status()

    soup = BeautifulSoup(resp.text, "html.parser")
    rows = soup.select("tr.tCenter.hl-tr")

    if not rows:
        print("No results found")
        return

    results = []
    for row in rows:
        topic_link = row.select_one("a.tLink")
        if not topic_link:
            continue

        topic_id = str(topic_link["href"]).split("=")[-1]
        title = unescape(topic_link.get_text(strip=True))

        size_el = row.select_one("td.tor-size a, td.tor-size")
        size_text = ""
        if size_el:
            raw = size_el.get("data-ts_text")
            if raw:
                size_text = format_size(int(str(raw)))
            else:
                size_text = size_el.get_text(strip=True)

        seeds_el = row.select_one("td.seed b, b.seedmed")
        seeds = seeds_el.get_text(strip=True) if seeds_el else "0"

        results.append(
            {
                "topic_id": topic_id,
                "title": title,
                "size": size_text,
                "seeds": seeds,
            }
        )

    # Print table
    id_w = max(len(r["topic_id"]) for r in results)
    size_w = max(len(r["size"]) for r in results)
    seeds_w = max(len(r["seeds"]) for r in results)

    header = f"{'ID':<{id_w}}  {'Size':>{size_w}}  {'Seeds':>{seeds_w}}  Title"
    print(header)
    print("-" * len(header))

    for r in results:
        print(
            f"{r['topic_id']:<{id_w}}  {r['size']:>{size_w}}  {r['seeds']:>{seeds_w}}  {r['title']}"
        )


def cmd_info(args):
    session = create_session()
    login(session)

    resp = session.get(TOPIC_URL, params={"t": args.topic_id})
    resp.raise_for_status()

    soup = BeautifulSoup(resp.text, "html.parser")
    post_body = soup.select_one(".post_body")
    if not post_body:
        print("Error: could not find post body", file=sys.stderr)
        sys.exit(1)

    # Replace <br> with newlines before extracting text
    for br in post_body.find_all("br"):
        br.replace_with("\n")

    print(post_body.get_text(separator="\n", strip=False).strip())


def cmd_download(args):
    session = create_session()
    login(session)

    resp = session.get(
        DOWNLOAD_URL,
        params={"t": args.topic_id},
    )
    resp.raise_for_status()

    if "application/x-bittorrent" not in resp.headers.get("Content-Type", ""):
        print(
            f"Error: unexpected content type: {resp.headers.get('Content-Type')}",
            file=sys.stderr,
        )
        sys.exit(1)

    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    output_path = output_dir / f"{args.topic_id}.torrent"

    output_path.write_bytes(resp.content)
    print(output_path)


def main():
    parser = argparse.ArgumentParser(description="Rutracker CLI")
    sub = parser.add_subparsers(dest="command", required=True)

    sub.add_parser("login", help="Test authentication")

    search_p = sub.add_parser("search", help="Search torrents")
    search_p.add_argument("query", help="Search query")

    info_p = sub.add_parser("info", help="Show torrent description")
    info_p.add_argument("topic_id", help="Topic ID")

    dl_p = sub.add_parser("download", help="Download .torrent file")
    dl_p.add_argument("topic_id", help="Topic ID")
    dl_p.add_argument("output_dir", help="Output directory")

    args = parser.parse_args()
    commands = {
        "login": cmd_login,
        "search": cmd_search,
        "info": cmd_info,
        "download": cmd_download,
    }
    commands[args.command](args)


if __name__ == "__main__":
    main()
