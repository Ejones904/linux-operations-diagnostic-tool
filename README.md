# Linux Operations Diagnostic Tool

A Bash-based Linux health-check utility designed to standardize initial system triage across common operational areas including resource utilization, networking, service status, and system information.

The project focuses on practical Linux operations, repeatable diagnostics, threshold-based health classification, and report generation.

---

## Project Overview

The goal of this project was to create a lightweight diagnostic tool that could quickly collect the most useful information needed during an initial Linux system investigation.

Instead of manually running multiple commands during every troubleshooting session, the script consolidates those checks into a single workflow.

The tool evaluates:

* system information
* current user context
* memory usage
* disk utilization
* CPU load
* active network interface
* default gateway
* external connectivity
* SSH service status

It then generates a reusable health report.

---

## Technology Stack

| Technology  | Purpose                       |
| ----------- | ----------------------------- |
| Bash        | Automation and scripting      |
| Linux       | Target operating environment  |
| `free`      | Memory utilization            |
| `df`        | Disk utilization              |
| `uptime`    | System uptime and load        |
| `ip route`  | Network and gateway discovery |
| `ping`      | Connectivity validation       |
| `systemctl` | Service status validation     |
| `awk`       | Command output processing     |

---

## Operational Workflow

```text
Run health_check.sh
        |
        v
Collect System Information
        |
        v
Check Resource Utilization
        |
        v
Validate Network Connectivity
        |
        v
Check SSH Service
        |
        v
Classify Health Status
        |
        v
Generate Diagnostic Report
```

The script is intentionally read-only and does not modify system configuration.

---

## Key Engineering Decisions

### Standardized Initial Triage

Linux troubleshooting often begins with the same questions:

* Is the system under resource pressure?
* Is storage approaching capacity?
* Is the host reachable?
* Is networking configured correctly?
* Is the required service running?

The script standardizes those first checks so the same baseline information can be collected consistently.

---

### Threshold-Based Health Classification

Memory and disk utilization are automatically evaluated against defined thresholds.

Current thresholds:

```text
Memory usage > 80%  → WARNING
Disk usage > 80%    → WARNING
Otherwise           → HEALTHY
```

This allows the output to highlight conditions that may require further investigation instead of presenting only raw metrics.

---

### Read-Only Diagnostics

The script collects operational data without restarting services, deleting files, or changing system configuration.

This makes it suitable as an initial diagnostic step before corrective actions are taken.

---

### Persistent Reporting

The tool writes its results to:

```text
reports/linux_health_report.txt
```

This creates a simple record that can be reviewed later or attached to a troubleshooting case.

---

## Implementation

The script collects system and operational information using standard Linux utilities.

Key data points include:

* hostname
* current user
* current date and time
* kernel version
* uptime
* IP address
* user ID
* group membership
* memory utilization
* root filesystem utilization
* CPU load average
* default network interface
* default gateway
* external connectivity
* SSH service state

The results are grouped into logical sections and displayed in a consistent format.

Detailed commands and development history are preserved in [`IMPLEMENTATION.md`](IMPLEMENTATION.md).

---

## Health Checks

### System Information

The tool collects:

* hostname
* kernel version
* uptime
* IP address

This provides immediate context about the system being inspected.

---

### User Information

The script identifies:

* current user
* user ID
* group membership

This helps confirm the permissions and execution context of the diagnostic session.

---

### Resource Utilization

The script checks memory usage and root filesystem utilization.

Memory utilization is calculated from `free` output, while disk utilization is collected from:

```bash
df /
```

Values above the configured threshold are flagged as warnings.

---

### Network Validation

The script identifies the system's default interface and gateway using:

```bash
ip route
```

It also performs an external connectivity test.

A successful test is reported as:

```text
SUCCESS
```

A failed test is reported as:

```text
FAILED
```

---

### Service Validation

The tool checks whether the SSH service is active using `systemctl`.

The service is classified as either:

```text
HEALTHY
```

or:

```text
WARNING
```

depending on its current state.

---

## Validation

The script was validated by running the complete diagnostic workflow and confirming that each section returned system data successfully.

### Full Diagnostic Execution

Add the screenshot showing the completed script output here:

```markdown
![Linux Health Check Execution](screenshots/<your-terminal-screenshot>.png)
```

### Generated Report

The generated report was also reviewed to confirm that the collected system, resource, network, and service information was written successfully.

```markdown
![Generated Linux Health Report](screenshots/<your-report-screenshot>.png)
```

Only these two screenshots are really needed in the README.

---

## Troubleshooting Value

The tool is designed to accelerate the first phase of Linux troubleshooting.

For example, if an application becomes unavailable, the diagnostic output can quickly help determine whether the issue is associated with:

```text
System Resources
      |
      +--> High memory usage
      |
      +--> High disk usage

Networking
      |
      +--> Missing route
      |
      +--> Connectivity failure

Services
      |
      +--> SSH or another monitored service inactive
```

The output does not automatically determine root cause, but it provides a consistent evidence set for further investigation.

---

## Current Limitations

This tool is intentionally lightweight.

It is not intended to replace:

* continuous monitoring platforms
* Prometheus or Grafana
* centralized logging
* security scanning
* full root-cause analysis
* enterprise observability tooling

The current implementation also checks only a limited set of services and thresholds.

---

## Security Considerations

The script performs read-only system checks and does not require destructive operations.

Operational considerations include:

* avoid storing sensitive command output in public repositories
* restrict report permissions where system details may be sensitive
* avoid exposing internal IP addresses or environment information publicly
* run diagnostics with only the privileges required for the checks being performed

---

## What This Project Demonstrates

This project demonstrates practical experience with:

* Linux systems administration
* Bash scripting
* system health diagnostics
* process and service investigation
* resource monitoring
* networking fundamentals
* command-output parsing
* threshold-based automation
* report generation
* operational troubleshooting methodology

---

## Future Enhancements

Potential improvements include:

* configurable warning and critical thresholds
* command-line arguments
* configurable service checks
* CPU utilization thresholds
* port availability checks
* DNS validation
* HTTP endpoint checks
* timestamped historical reports
* JSON output
* cron-based scheduled execution
* structured logging
* alerting integration

---

## Repository Documentation

* [`README.md`](README.md) — engineering overview and operational purpose
* [`IMPLEMENTATION.md`](IMPLEMENTATION.md) — detailed implementation history

---

## Engineering Outcome

The project converts a collection of common Linux troubleshooting commands into a repeatable diagnostic workflow.

The result is a lightweight operational tool that improves consistency during initial system triage while preserving the underlying Linux commands and concepts required for deeper troubleshooting.
