#!/usr/bin/env python3
"""Yandex Music CLI: search tracks/albums and download via yandex-music-downloader."""

import argparse
import os
import subprocess
import sys
from pathlib import Path

# yandex_music is installed inside pipx venv alongside yandex-music-downloader
try:
    import yandex_music
except ImportError:
    _site = Path.home() / ".local/share/pipx/venvs/yandex-music-downloader/lib"
    _sp = next(_site.glob("python*/site-packages"), None)
    if _sp:
        sys.path.insert(0, str(_sp))
    import yandex_music


def get_token():
    token = os.environ.get("YANDEX_MUSIC_TOKEN")
    if not token:
        print(
            "Error: YANDEX_MUSIC_TOKEN environment variable required",
            file=sys.stderr,
        )
        sys.exit(1)
    return token


def create_client():
    return yandex_music.Client(get_token()).init()


def format_duration(ms):
    if ms is None:
        return "?"
    s = ms // 1000
    return f"{s // 60}:{s % 60:02d}"


def artists_str(artists):
    if not artists:
        return "?"
    return ", ".join(a.name for a in artists)


def cmd_search_tracks(args):
    client = create_client()
    result = client.search(args.query, type_="track")

    if not result or not result.tracks or not result.tracks.results:
        print("No results found")
        return

    tracks = result.tracks.results

    rows = []
    for t in tracks:
        album_title = ""
        album_id = ""
        if t.albums:
            album_title = t.albums[0].title or ""
            album_id = str(t.albums[0].id)
        rows.append(
            {
                "id": str(t.id),
                "artist": artists_str(t.artists),
                "title": t.title or "",
                "album": album_title,
                "duration": format_duration(t.duration_ms),
                "url": f"https://music.yandex.ru/album/{album_id}/track/{t.id}"
                if album_id
                else "",
            }
        )

    id_w = max(len(r["id"]) for r in rows)
    dur_w = max(len(r["duration"]) for r in rows)

    header = f"{'ID':<{id_w}}  {'Artist':<20}  {'Title':<25}  {'Album':<25}  {'Dur':>{dur_w}}  URL"
    print(header)
    print("-" * len(header))

    for r in rows:
        print(
            f"{r['id']:<{id_w}}  {r['artist']:<20}  {r['title']:<25}  {r['album']:<25}  {r['duration']:>{dur_w}}  {r['url']}"
        )


def cmd_search_albums(args):
    client = create_client()
    result = client.search(args.query, type_="album")

    if not result or not result.albums or not result.albums.results:
        print("No results found")
        return

    albums = result.albums.results

    rows = []
    for a in albums:
        rows.append(
            {
                "id": str(a.id),
                "artist": artists_str(a.artists),
                "title": a.title or "",
                "year": str(a.year) if a.year else "",
                "tracks": str(a.track_count) if a.track_count else "",
                "url": f"https://music.yandex.ru/album/{a.id}",
            }
        )

    id_w = max(len(r["id"]) for r in rows)
    year_w = max(len(r["year"]) for r in rows)
    trk_w = max(len(r["tracks"]) for r in rows)

    header = f"{'ID':<{id_w}}  {'Artist':<20}  {'Title':<25}  {'Year':>{year_w}}  {'Tracks':>{trk_w}}  URL"
    print(header)
    print("-" * len(header))

    for r in rows:
        print(
            f"{r['id']:<{id_w}}  {r['artist']:<20}  {r['title']:<25}  {r['year']:>{year_w}}  {r['tracks']:>{trk_w}}  {r['url']}"
        )


def cmd_download_track(args):
    token = get_token()
    cmd = [
        "yandex-music-downloader",
        "--token",
        token,
        "--quality",
        "2",
        "--embed-cover",
        "--track-id",
        args.track_id,
        "--dir",
        args.output_dir,
        "--path-pattern",
        "#track-artist/#album/#number-padded - #title",
    ]
    subprocess.run(cmd, check=True)


def cmd_download_album(args):
    token = get_token()
    cmd = [
        "yandex-music-downloader",
        "--token",
        token,
        "--quality",
        "2",
        "--embed-cover",
        "--album-id",
        args.album_id,
        "--dir",
        args.output_dir,
        "--path-pattern",
        "#track-artist/#album/#number-padded - #title",
    ]
    subprocess.run(cmd, check=True)


def main():
    parser = argparse.ArgumentParser(description="Yandex Music CLI")
    sub = parser.add_subparsers(dest="command", required=True)

    st = sub.add_parser("search-tracks", help="Search tracks")
    st.add_argument("query", help="Search query")

    sa = sub.add_parser("search-albums", help="Search albums")
    sa.add_argument("query", help="Search query")

    dt = sub.add_parser("download-track", help="Download single track (FLAC)")
    dt.add_argument("track_id", help="Track ID")
    dt.add_argument("output_dir", help="Output directory")

    da = sub.add_parser("download-album", help="Download full album (FLAC)")
    da.add_argument("album_id", help="Album ID")
    da.add_argument("output_dir", help="Output directory")

    args = parser.parse_args()
    commands = {
        "search-tracks": cmd_search_tracks,
        "search-albums": cmd_search_albums,
        "download-track": cmd_download_track,
        "download-album": cmd_download_album,
    }
    commands[args.command](args)


if __name__ == "__main__":
    main()