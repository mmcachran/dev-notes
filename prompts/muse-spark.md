```txt
/plan "Architect and engineer a zero-trust, high-performance, open-source network monitoring and SSH management toolkit optimized for resource-constrained Raspberry Pis, compiled into a single OS-agnostic binary or portable image using FrankenPHP."

/goal
- Configure a multi-stage, multi-arch Dockerfile (x86_64, ARMv7, ARM64) utilizing FrankenPHP compiled with strict hardening flags (rootless execution, CAP_DROP ALL, CAP_ADD NET_RAW, no-new-privileges).
- Build a dynamic environment-driven port allocation fallback mechanism ($APP_PORT, defaulting to 8080 if 80/443 are occupied) that performs low-level port probing at host execution time.
- Implement an ultra-fast, non-blocking asynchronous local subnet scanner utilizing PHP 8.1+ Concurrency Fibers to orchestrate low-timeout raw ping and ARP sweeps without thread exhaustion.
- Engineer a reliable dual-tier hardware fingerprinter that matches real-time MAC addresses against an embedded Raspberry Pi OUI dataset and handles non-intrusive SSH banner grabbing.
- Develop a cryptographically isolated credential vault using AES-256-GCM, where the symmetric key is dynamically derived at application boot by hashing the physical host device's persistent immutable traits (e.g., machine-id, hardware UUID) combined with a local random cryptographic salt.
- Enforce strict perimeter security for the Web UI: prevent exposure to the broadcast network by routing through localhost by default, or implement an on-demand, time-decaying, high-entropy alpha-numeric PIN auth sequence generated inside the terminal console upon deployment.
- Deliver an interactive, responsive single-file Web Dashboard (Tailwind CSS, Alpine.js, and Server-Sent Events for real-time streaming updates) paired with a clean console-based terminal interface sharing unified core services.
- Code zero-downtime micro-lifecycle management workflows: automated script-based installers, transactional SQLite schema migrations with automated rollbacks upon failure, state preservation routines, and embedded markdown technical documentation served natively from an memory-cached routing layer.

Enhancement & Git Branching Loop:
1. branch: "feature/secure-lifecycle-setup" -> Deliver the dynamic port configuration engine, host-bound cryptography matrix, system capability drop configuration, and container entrypoint scripting.
2. branch: "feature/async-discovery-engine" -> Implement the concurrent PHP Fiber network discovery sweep and multi-layered hardware fingerprinting hooks.
3. branch: "feature/crypto-vault-layer" -> Code the AES-256-GCM database encryption safe using hardware derived key seeds and implement non-blocking secure SSH terminal interaction.
4. branch: "feature/dual-ui-and-docs" -> Integrate the SSE web control panel, secure console PIN validator interface, and self-hosted technical documentation layer.

Constraints:
- 100% telemetry-free and cloud-independent local deployment; all states, credential safe blocks, and analytical operations must remain strictly local.
- High memory efficiency to protect low-power processing environments (e.g., Raspberry Pi Zero 2 W or original Pi 3).
- Absolute separation of concerns: scanning logic, crypto-safes, and visualization frameworks must run decoupled.
```
