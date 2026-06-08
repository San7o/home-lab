Legislations
============

When publishing software, you need to follow some legislations.

EU Cyber Resilience Act (CRA)
-----------------------------

Focuses strictly on digital product security and software supply chain
integrity. It applies to any product with digital elements sold in the EU.

* Mandatory SBOM: You must generate, sign, and maintain a machine-readable
  Software Bill of Materials (typically SPDX or CycloneDX formats) for every
  production release to track dependencies.

* Vulnerability Handling: You must have a coordinated vulnerability
  disclosure (CVD) process. Exploited vulnerabilities must be reported to
  ENISA/national authorities within 24 hours.

* Security Lifecycle: You must provide security patches for the expected
  lifetime of the product or for a minimum of 5 years.

* The Developer Takeaway: If you ship commercial binaries, you own the
  security debt of every upstream open-source component you pulled into your
  build.

GDPR
----

Focuses strictly on personal data privacy, sovereignty, and data protection by
design.

* Scope: Regulates how personal identifiable information (PII) of EU citizens is
  collected, processed, stored, and deleted.

* Technical Measures: Article 32 mandates "appropriate technical and
  organisational measures." While it does not explicitly mention software
  manifests, running an unpatched stack that leads to a data breach is legally
  evaluated as gross negligence.

* The Developer Takeaway: Data minimization is an architectural goal. If your
  database schema or log files store PII that your core logic doesn't strictly
  need, you are carrying unnecessary compliance risk.

EU AI Act
----------

A risk-based framework regulating machine learning, statistical models, and
artificial intelligence systems.

* Risk Tiers: Classification ranges from Minimal Risk (spam filters) to
  High-Risk (critical infrastructure, employment software) and Prohibited
  (biometric surveillance).

* Transparency Mandate: Any generative output must be machine-readable and
  watermarked/labeled so humans know they are interacting with synthetic
  content.

* High-Risk Requirements: Requires robust data governance, detailed event
  logging, rigorous risk management, and human-in-the-loop oversight mechanisms.

* The Developer Takeaway: Even if you just wrap a third-party LLM API, you are
  legally responsible for transparency and classification compliance based on
  *your* application's deployment context.

NIS2 Directive
--------------

Focuses on infrastructure, operational resilience, and supply chain security
for critical entities. Transposed in Italy via *D.Lgs. 138/2024*.

* Scope: Targets "Essential" and "Important" sectors (energy, transport,
  banking, cloud computing, digital providers).

* Supply Chain Audits: Covered entities are legally forced to audit the security
  posture of their third-party software vendors. 

* Incident Reporting: Mandates a strict 24-hour early warning window to CSIRT
  Italy / national authorities following a significant cyber incident.

* The Developer Takeaway: Your deployment pipelines and infrastructure must
  feature aggressive telemetry and logging. If your app gets breached, you must
  be able to generate a forensic trail within hours.

Digital Operational Resilience Act (DORA)
-----------------------------------------

A specialized digital resilience framework explicitly targeting the financial
sector and its critical ICT third-party service providers.

* Scope: Applies to banks, investment firms, and any tech company providing
  SaaS, cloud infrastructure, or critical software to financial institutions.

* Requirements: Mandates formal threat-led penetration testing (TLPT), real-time
  ICT risk management, and rigorous change-management tracking.

* The Developer Takeaway: Code updates to financial sector integrations cannot
  be cowboyed. Every merge requires an immutable audit trail of testing, peer
  review, and risk validation.

European Conformity (CE)
------------------------

A mandatory legal declaration of product conformity required to place
specific goods on the European Economic Area market. It is *not* a quality seal.

* The Process: To affix the CE mark, the manufacturer must compile a
  comprehensive *Technical Documentation File* (schematics, risk matrix, test
  logs) and sign an *EU Declaration of Conformity*.

* Conformity Modes: Low-risk products can self-certify. High-risk products
  require a third-party audit by an accredited *Notified Body*.

* The Convergence: Historically an electrical/hardware concern (EMC, RoHS),
  software is now integrated into CE marking via the CRA and AI Act. A digital
  product cannot bear the CE mark unless its software layer complies with those
  security baselines.

* The Developer Takeaway: You do not "become" CE compliant simply by following
  GDPR or DORA. CE marking is the formalized, signed compilation output proving
  you successfully passed every applicable directive's verification check.
