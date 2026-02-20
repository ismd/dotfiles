#!/usr/bin/env python3
"""MusicBrainz CLI: search artists, browse albums, and look up releases."""

import argparse
import sys

import musicbrainzngs

musicbrainzngs.set_useragent("claude-music-skill", "1.0", "noreply@example.com")


def cmd_search_artist(args):
    try:
        result = musicbrainzngs.search_artists(artist=args.name, limit=5)
    except musicbrainzngs.WebServiceError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    artists = result.get("artist-list", [])
    if not artists:
        print("No artists found")
        return

    rows = []
    for a in artists:
        rows.append(
            {
                "id": a.get("id", ""),
                "name": a.get("name", ""),
                "disambig": a.get("disambiguation", ""),
                "type": a.get("type", ""),
                "country": a.get("country", ""),
                "score": a.get("ext:score", ""),
            }
        )

    id_w = max(len(r["id"]) for r in rows)
    name_w = max(len(r["name"]) for r in rows)
    dis_w = max(len(r["disambig"]) for r in rows)
    type_w = max(len(r["type"]) for r in rows)
    co_w = max(len(r["country"]) for r in rows)

    header = f"{'ID':<{id_w}}  {'Name':<{name_w}}  {'Disambiguation':<{dis_w}}  {'Type':<{type_w}}  {'Country':<{co_w}}  Score"
    print(header)
    print("-" * len(header))

    for r in rows:
        print(
            f"{r['id']:<{id_w}}  {r['name']:<{name_w}}  {r['disambig']:<{dis_w}}  {r['type']:<{type_w}}  {r['country']:<{co_w}}  {r['score']}"
        )


def cmd_artist_albums(args):
    type_map = {
        "album": ["album"],
        "compilation": ["compilation"],
        "ep": ["ep"],
        "single": ["single"],
        "live": ["live"],
        "all": ["album", "compilation", "ep", "single", "live"],
    }
    release_types = type_map.get(args.type, ["album"])

    try:
        groups = []
        offset = 0
        while True:
            result = musicbrainzngs.browse_release_groups(
                artist=args.artist_id,
                release_type=release_types,
                limit=100,
                offset=offset,
            )
            batch = result.get("release-group-list", [])
            groups.extend(batch)
            if len(batch) < 100:
                break
            offset += 100
    except musicbrainzngs.WebServiceError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    if not groups:
        print("No release groups found")
        return

    rows = []
    for rg in groups:
        year = rg.get("first-release-date", "")[:4]
        rows.append(
            {
                "id": rg.get("id", ""),
                "title": rg.get("title", ""),
                "type": rg.get("primary-type", rg.get("type", "")),
                "year": year,
            }
        )

    rows.sort(key=lambda r: r["year"] or "9999")

    id_w = max(len(r["id"]) for r in rows)
    title_w = max(len(r["title"]) for r in rows)
    type_w = max(len(r["type"]) for r in rows)

    header = f"{'ReleaseGroup ID':<{id_w}}  {'Title':<{title_w}}  {'Type':<{type_w}}  Year"
    print(header)
    print("-" * len(header))

    for r in rows:
        print(
            f"{r['id']:<{id_w}}  {r['title']:<{title_w}}  {r['type']:<{type_w}}  {r['year']}"
        )


def cmd_search_release(args):
    try:
        query_parts = []
        if args.artist:
            query_parts.append(f'artist:"{args.artist}"')
        if args.catno:
            query_parts.append(f'catno:"{args.catno}"')
        query = " AND ".join(query_parts)
        result = musicbrainzngs.search_releases(query=query, limit=10)
    except musicbrainzngs.WebServiceError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    releases = result.get("release-list", [])
    if not releases:
        print("No releases found")
        return

    rows = []
    for rel in releases:
        label_info = rel.get("label-info-list", [{}])
        label = label_info[0].get("label", {}).get("name", "") if label_info else ""
        catno = label_info[0].get("catalog-number", "") if label_info else ""
        media = rel.get("medium-list", [{}])
        fmt = media[0].get("format", "") if media else ""
        rows.append(
            {
                "id": rel.get("id", ""),
                "title": rel.get("title", ""),
                "date": rel.get("date", ""),
                "country": rel.get("country", ""),
                "label": label,
                "catno": catno,
                "format": fmt,
            }
        )

    id_w = max(len(r["id"]) for r in rows)
    title_w = max(len(r["title"]) for r in rows)
    date_w = max(len(r["date"]) for r in rows)
    co_w = max(len(r["country"]) for r in rows)
    label_w = max(len(r["label"]) for r in rows)
    cat_w = max(len(r["catno"]) for r in rows)

    header = (
        f"{'ID':<{id_w}}  {'Title':<{title_w}}  {'Date':<{date_w}}  "
        f"{'Country':<{co_w}}  {'Label':<{label_w}}  {'Catno':<{cat_w}}  Format"
    )
    print(header)
    print("-" * len(header))

    for r in rows:
        print(
            f"{r['id']:<{id_w}}  {r['title']:<{title_w}}  {r['date']:<{date_w}}  "
            f"{r['country']:<{co_w}}  {r['label']:<{label_w}}  {r['catno']:<{cat_w}}  {r['format']}"
        )


def cmd_release_group_releases(args):
    try:
        releases = []
        offset = 0
        while True:
            result = musicbrainzngs.browse_releases(
                release_group=args.rg_id,
                includes=["labels", "media"],
                limit=100,
                offset=offset,
            )
            batch = result.get("release-list", [])
            releases.extend(batch)
            if len(batch) < 100:
                break
            offset += 100
    except musicbrainzngs.WebServiceError as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    if not releases:
        print("No releases found")
        return

    rows = []
    for rel in releases:
        label_info = rel.get("label-info-list", [{}])
        label = label_info[0].get("label", {}).get("name", "") if label_info else ""
        catno = label_info[0].get("catalog-number", "") if label_info else ""
        media = rel.get("medium-list", [{}])
        fmt = media[0].get("format", "") if media else ""
        rows.append(
            {
                "id": rel.get("id", ""),
                "title": rel.get("title", ""),
                "date": rel.get("date", ""),
                "country": rel.get("country", ""),
                "label": label,
                "catno": catno,
                "format": fmt,
            }
        )

    rows.sort(key=lambda r: r["date"] or "9999")

    id_w = max(len(r["id"]) for r in rows)
    title_w = max(len(r["title"]) for r in rows)
    date_w = max(len(r["date"]) for r in rows)
    co_w = max(len(r["country"]) for r in rows)
    label_w = max(len(r["label"]) for r in rows)
    cat_w = max(len(r["catno"]) for r in rows)

    header = (
        f"{'ID':<{id_w}}  {'Title':<{title_w}}  {'Date':<{date_w}}  "
        f"{'Country':<{co_w}}  {'Label':<{label_w}}  {'Catno':<{cat_w}}  Format"
    )
    print(header)
    print("-" * len(header))

    for r in rows:
        print(
            f"{r['id']:<{id_w}}  {r['title']:<{title_w}}  {r['date']:<{date_w}}  "
            f"{r['country']:<{co_w}}  {r['label']:<{label_w}}  {r['catno']:<{cat_w}}  {r['format']}"
        )


def main():
    parser = argparse.ArgumentParser(description="MusicBrainz CLI")
    sub = parser.add_subparsers(dest="command", required=True)

    sa_p = sub.add_parser("search-artist", help="Search for artists by name")
    sa_p.add_argument("name", help="Artist name")

    aa_p = sub.add_parser("artist-albums", help="Get release groups for an artist")
    aa_p.add_argument("artist_id", help="MusicBrainz artist ID")
    aa_p.add_argument(
        "--type",
        choices=["album", "compilation", "ep", "single", "live", "all"],
        default="album",
        help="Release group type (default: album)",
    )

    sr_p = sub.add_parser("search-release", help="Search for specific releases")
    sr_p.add_argument("--artist", required=True, help="Artist name")
    sr_p.add_argument("--catno", help="Catalog number")

    rr_p = sub.add_parser(
        "release-group-releases", help="List all releases in a release group"
    )
    rr_p.add_argument("rg_id", help="Release group ID")

    args = parser.parse_args()
    commands = {
        "search-artist": cmd_search_artist,
        "artist-albums": cmd_artist_albums,
        "search-release": cmd_search_release,
        "release-group-releases": cmd_release_group_releases,
    }
    commands[args.command](args)


if __name__ == "__main__":
    main()
