# Scenario Probe

An Antigravity & Agentic IDE Skill designed for autonomous end-to-end user scenario simulations, user flow generation, capability gap audits, and system readiness scoring.

## Overview

Software systems and AI workstations often appear feature-complete on paper, but break down when an actual user arrives with a concrete, ambiguous, or edge-case creative seed. 

`scenario-probe` puts any codebase through a realistic user scenario trial:
- Synthesizes realistic user personas with explicit knowledge constraints.
- Deconstructs raw creative/business seeds into mandatory domain pillars.
- Traces step-by-step user journeys through the application's actual UI and backend seams.
- Evaluates friction, dead-ends, and unhandled sub-needs with zero hallucination.
- Produces a multi-dimensional system scorecard and an actionable engineering remediation plan.

## Quick Start / Triggers

In any Antigravity chat session, trigger the skill by invoking:

```text
test <scenario / user seed>
```
*Examples:*
- `test bulutların üzerindeki bir dünyaya ait animasyonlar yapmak`
- `test guest checkout flow with discount code`
- `test multi-character pantomime episode production`

Or invoke explicitly:
```text
scenario-probe <target workflow>
```

## Global Installation

Install globally into your Antigravity environment:

```bash
mkdir -p ~/.gemini/config/skills/scenario-probe
cp SKILL.md ~/.gemini/config/skills/scenario-probe/SKILL.md
```

## Structure
- [`SKILL.md`](SKILL.md): Authoritative operational rules, reasoning constraints, 5-phase simulation protocol, and output schemas.
- [`scripts/sync.sh`](scripts/sync.sh): Synchronization utility to keep local repo and global Antigravity skills in sync.

---
Maintained under **Delizade-Antigravity-Skills**.
