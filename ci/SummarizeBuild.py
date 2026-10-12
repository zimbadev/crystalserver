from pathlib import Path
import argparse
import json


def collect(path):
    outputs = {}
    invalid = 0
    if path.exists():
        for line in path.read_text(errors="replace").splitlines():
            if line.startswith("#") or not line.strip():
                continue
            columns = line.split("\t")
            try:
                start, end = int(columns[0]), int(columns[1])
                output, command_hash = columns[3], columns[4]
                if start < 0 or end < start:
                    raise ValueError("Invalid task time")
            except (ValueError, IndexError):
                invalid += 1
                continue
            suffix = Path(output).suffix.lower()
            category = "other"
            if suffix in (".o", ".obj"):
                category = "compile"
            elif suffix in (".exe", ".dll", ".so", ".dylib") or (not suffix and "/bin/" in "/" + output.replace("\\", "/")):
                category = "link"
            elif suffix in (".lib", ".a"):
                category = "archive"
            elif suffix in (".pch", ".gch"):
                category = "pch"
            outputs[output] = (start, end, command_hash, category)

    # A Ninja edge can emit an executable, PDB and discovery file together.
    # Its elapsed time must be counted once, not once per output.
    edges = {}
    priority = {name: i for i, name in enumerate(("link", "pch", "archive", "compile", "other"))}
    for output, (start, end, command_hash, category) in outputs.items():
        key = (start, end, command_hash)
        row = edges.setdefault(key, {"output": output, "outputs": [], "category": category, "start_ms": start, "end_ms": end, "seconds": round((end - start) / 1000, 3)})
        row["outputs"].append(output)
        if priority[category] < priority[row["category"]]:
            row.update(output=output, category=category)
    rows = sorted(edges.values(), key=lambda row: row["seconds"], reverse=True)
    return {
        "ninja_log_present": path.exists(), "invalid_records": invalid,
        "task_count": len(rows), "output_count": len(outputs),
        "category_seconds_sum": {name: round(sum(row["seconds"] for row in rows if row["category"] == name), 3) for name in priority},
        "note": "Task durations can overlap; sums are not build wall time. Reused logs can contain records from earlier builds.",
        "tasks": rows,
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("build_dir", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(collect(args.build_dir / ".ninja_log"), indent=2) + "\n")