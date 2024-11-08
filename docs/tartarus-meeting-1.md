---
title:  Tartarus Meeting #1
subtitle: Welcome to Hell!
date: 2024-11-07
---

# Agenda

----

* Introduction round: why we are here?
* Local cluster experiments (Brian W. Bush)
* A VPN for Tartarus (Arnaud Bailly)
* Next steps (discussion)

# Local Cluster Experiment

- *Purpose:* highlight issues and techniques for adversial network studies
- *Approach:* start small and check against theory
- Initial network ("Proserpina")
    - Five honest nodes (56% stake)
    - Four adversarial nodes (44% stake)
    - Control over network connecting honest and adversarial nodes
- Two studies
    - Check block production against theory
    - Private-fork attack

# Diagnostic study

- Simpy observe block production in the network
- Statistical tests
    - Correct number of blocks are produced
    - All nodes produce blocks at the same rate
    - Gaps in block production are geometrically distributed
- https://github.com/cardano-scaling/tartarus/blob/main/proserpina/diagnostics.ipynb

# Private Adversarial Fork - Setup

0. The honest party has $p$ of the stake and the adversary has $q$ of the stake:
1. Adversary isolates their nodes from the honest ones.
2. Adversary builds a private fork.
3. If the honest fork becomes $m$ blocks longer than the private adversarial fork, then the adversary gives up.
4. If the private adversarial fork becomes $n$ blocks longer than the honest fork, then the adversary rejoins the honest network, revealing their longer chain to the honest parties, who are compelled to adopt it in favor of their shorter honest fork.

# Private Adversarial Fork - Results

- Five times realtime: 0.2 slot/second
- Approximately 1400 attacks in 24 hours
    - 56 successful attacks
    - 1349 failed attacks
- Theory predicts a 4.15% success rate
- Actual success rate is 3.99%
- A chi-squared test indicates that actuality matches expectations

# Running Tartarus over VPN


# Discussion
