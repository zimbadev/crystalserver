#!/usr/bin/env python3
"""Turn build logs into GitHub annotations and a step summary.

Usage: report_build.py [--title TEXT] LOG [LOG...]

The interesting lines of a failed configure/build/test log (compiler and linker errors, CMake
errors, failed Ninja edges, failed tests) are printed as `::error` workflow commands, so they show
up on the run page and in the checks API without opening the raw log. Compiler errors keep their
file and line. The same lines, plus the compiler cache statistics found in the logs, go to
$GITHUB_STEP_SUMMARY.

Always exits 0: reporting must never change the result of the job.
"""

import argparse
import os
import re
import sys
from pathlib import Path

MAX_ANNOTATIONS = 30
MAX_SUMMARY_LINES = 80
MAX_MESSAGE = 900

# file:line[:col]: error|fatal error: message   (GCC / Clang)
GCC_ERROR = re.compile(r"^(?P<file>[^\s:][^:\n]*):(?P<line>\d+)(?::(?P<col>\d+))?:\s+(?:fatal\s+)?error:\s+(?P<msg>.*)$")
# file(line[,col]): error C1234: message        (MSVC)
MSVC_ERROR = re.compile(r"^(?P<file>[^(\n]+)\((?P<line>\d+)(?:,(?P<col>\d+))?\)\s*:\s+(?:fatal\s+)?error\s+(?P<msg>[A-Z]+\d+:.*)$")
OTHER_ERROR = re.compile(
	r"(undefined reference to|multiple definition of|ld(\.\w+)?: error|mold: error|collect2: error|"
	r"error LNK\d+|CMake Error|^FAILED: |ninja: build stopped|No rule to make target|"
	r"error: building .* failed with|\*\*\*Failed|\(Failed\)|tests failed out of|"
	r"Could not find a package configuration file|sccache: error|ccache: error)"
)
CACHE_STAT = re.compile(r"^\s*(Hits|Misses|Cacheable calls|Uncacheable calls|Cache hits|Cache misses|Cache size \(GB\)|Cache size)\b.*$", re.I)
ANSI = re.compile(r"\x1b\[[0-9;]*[A-Za-z]")


def escape_data(text):
	return text.replace("%", "%25").replace("\r", "%0D").replace("\n", "%0A")


def escape_property(text):
	return escape_data(text).replace(":", "%3A").replace(",", "%2C")


def relative_to_workspace(path):
	workspace = os.environ.get("GITHUB_WORKSPACE", "")
	path = path.strip().replace("\\", "/")
	if workspace:
		workspace = workspace.replace("\\", "/").rstrip("/") + "/"
		if path.lower().startswith(workspace.lower()):
			path = path[len(workspace):]
	while path.startswith("../"):
		path = path[3:]
	return path


def scan(log_path):
	found = []
	stats = []
	try:
		lines = log_path.read_text(errors="replace").splitlines()
	except OSError:
		return found, stats

	for index, raw in enumerate(lines):
		line = ANSI.sub("", raw).rstrip()
		match = GCC_ERROR.match(line) or MSVC_ERROR.match(line)
		if match:
			# keep the next line: GCC prints the offending source line there
			context = ANSI.sub("", lines[index + 1]).rstrip() if index + 1 < len(lines) else ""
			message = match.group("msg")
			if context and not GCC_ERROR.match(context):
				message += "\n" + context
			found.append({"file": relative_to_workspace(match.group("file")), "line": match.group("line"), "message": message, "log": log_path.name})
		elif OTHER_ERROR.search(line):
			found.append({"file": "", "line": "", "message": line.strip(), "log": log_path.name})
		elif CACHE_STAT.match(line):
			stats.append(line.strip())
	return found, stats


def main():
	parser = argparse.ArgumentParser()
	parser.add_argument("--title", default="Build")
	parser.add_argument("logs", nargs="+")
	args = parser.parse_args()

	problems = []
	stats = []
	seen = set()
	for name in args.logs:
		found, log_stats = scan(Path(name))
		for item in found:
			key = (item["file"], item["line"], item["message"])
			if key not in seen:
				seen.add(key)
				problems.append(item)
		stats.extend(log_stats)

	for item in problems[:MAX_ANNOTATIONS]:
		properties = [f"title={escape_property(args.title + ' / ' + item['log'])}"]
		if item["file"]:
			properties.insert(0, f"file={escape_property(item['file'])}")
			properties.insert(1, f"line={item['line']}")
		print(f"::error {','.join(properties)}::{escape_data(item['message'][:MAX_MESSAGE])}")

	if len(problems) > MAX_ANNOTATIONS:
		print(f"::warning title={escape_property(args.title)}::{len(problems) - MAX_ANNOTATIONS} more problem lines are only in the uploaded logs")

	summary_path = os.environ.get("GITHUB_STEP_SUMMARY")
	if summary_path:
		with open(summary_path, "a", encoding="utf-8") as summary:
			summary.write(f"### {args.title}\n\n")
			if problems:
				summary.write(f"{len(problems)} problem line(s):\n\n```\n")
				for item in problems[:MAX_SUMMARY_LINES]:
					location = f"{item['file']}:{item['line']}: " if item["file"] else ""
					summary.write(f"[{item['log']}] {location}{item['message']}\n")
				summary.write("```\n\n")
			else:
				summary.write("No problem lines found in the logs.\n\n")
			if stats:
				summary.write("Compiler cache:\n\n```\n" + "\n".join(stats[-12:]) + "\n```\n\n")

	return 0


if __name__ == "__main__":
	sys.exit(main())
