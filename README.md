📊 FlousLek (فلوس لك)
The Automated Credit & Cashflow Manager for Egypt & MENA
FlousLek is an Android-first personal finance and credit management application built specifically to map real, fragmented financial behavior in Egypt and the MENA region. It completely eliminates the absolute friction of manual expense trackers by securely capturing, parsing, and reconciling institutional bank and wallet SMS text notifications locally and 100% on-device.

Unlike generic global budgeting apps that break when faced with complex local financial flows, FlousLek acts as a quiet financial companion that handles the chaos of mixed Arabic/English transaction receipts, maps rolling 55-day credit card grace periods, and automatically reconciles multi-account transfers to prevent double-counting.

🚀 The Core Moat & Problem Solved
Zero manual data entry friction: The application captures transactional data automatically via native on-device SMS interceptors. Manual adjustments serve exclusively as fallback options.
True Credit Cycle Modeling: Models custom rolling statement closures and grace periods (the local 55-day banking rule) to calculate precise interest-free deadlines instead of treating transactions uniformly.
Double-Counting Prevention: An accounting-grade internal transfer engine automatically identifies asynchronous multi-wallet flows (e.g., InstaPay cross-bank card payments or ATM cash routing) to avoid inflating monthly spending reports.
Offline Sovereign Privacy: 100% local processing. No user financial payloads, plain text messages, or balance statistics ever leave the physical hardware.
🛠️ The Architecture & Tech Strategy
This MVP repo follows a strict, PM-driven Vibe Coding blueprint designed for rapid, highly stable iterative growth with AI coding assistants (e.g., Cursor, Claude, Windsurf).

Frontend UI Framework: Flutter (Multiplatform UI engine configured for light/dark responsive scaling).
Native Integration Sub-Module: Kotlin Android Native platform channels to govern low-level hardware background states.
Local Secured Ledger: Local SQLite abstraction powered by encrypted SQLCipher and bound directly to the hardware-backed Android Keystore System.
State Management Architecture: Riverpod.
🛡️ The Anti-Kill Sync Ingestion Routine
Modern Android variations (OS 13, 14, and 15+) enforce highly aggressive battery optimization algorithms that terminate unpinned background processes. FlousLek neutralizes this ingestion vulnerability through a rigid triple-layered defense shield:

The Interceptor: A low-latency background Kotlin native BroadcastReceiver that captures live incoming operational streams.
The Keeper: A lightweight Foreground Service paired with a non-intrusive persistent system notification to prevent OS teardown.
The Net (Sync-on-Open): A programmatic historical scan of the local device SMS database that fires every time the application is actively opened, pulling and reconciling any unparsed bank timestamps missed during sleep states.
🗄️ Relational Database Layout Blueprint
The system data map utilizes an isolated relational local model optimized for transactional state management:

  ┌───────────────────────┐             ┌───────────────────────┐
  │   wallets_accounts    │             │     transactions      │
  ├───────────────────────┤             ├───────────────────────┤
  │ PK  id                │◄───┐        │ PK  id                │
  │     name              │    │        │ FK  wallet_id         │───┘
  │     type (Debit/Cred) │    └────────│     amount            │
  │     total_limit       │             │     currency (EGP/USD)│
  │     statement_day     │             │     vendor_name       │
  │     grace_period      │             │     transaction_type  │
  └───────────────────────┘             └───────────────────────┘
              │                                     ▲
              │ 1                                   │ 0..*
              └───┐                             ┌───┘
                  │ 1                           │ 1
  ┌───────────────────────┐             ┌───────────────────────┐
  │     transfer_logs     │             │    parse_failures     │
  ├───────────────────────┤             ├───────────────────────┤
  │ PK  id                │             │ PK  id                │
  │ FK  source_wallet_id  │             │     sender_id         │
  │     amount            │             │     raw_sms_body      │
  │     pending_status    │             │     timestamp         │
  │     timeout_timestamp │             └───────────────────────┘
  └───────────────────────┘
🗺️ Execution Roadmap (Sprints)
📦 Sprint 1: Local Ledger & Database Hardening (Weeks 1-2)
Scaffold Flutter directory layout alongside native Android Kotlin channel abstractions.
Initialize local encrypted database schema utilizing Drift/Room bound securely via SQLCipher.
Author seed unit tests verifying account instantiation properties (Debit, Credit, E-Wallet, Cash).
📡 Sprint 2: Core Hardware SMS Ingestion Engine (Weeks 3-5)
Wire the native Kotlin BroadcastReceiver to handle live institutional incoming streams.
Construct the Sync-on-Open background worker routines to execute structural catch-up scans.
Build the decoupled Strategy Parsing Pattern factories (CIBParser, NBEParser, VFCashParser) to map mixed Arabic/English text streams into uniform JSON structures.
🧠 Sprint 3: Credit Card Grace Periods & Asynchronous Routing (Weeks 6-7)
Implement the rolling 55-day due-date calculation algorithms.
Deploy the Asynchronous State Machine within transfer_logs to cleanly trap and reconcile cross-bank InstaPay settlements using a rolling 48-hour matching threshold.
Wire automated ATM deduction routines to directly route withdrawn assets to the local Cash Wallet bucket.
🎨 Sprint 4: Calming UI Presentation & Resilience Triggers (Week 8)
Construct the minimal, human-centric visual layouts focused on the single "Safe to Spend" (الكاش الجاهز) master banner.
Integrate the simplified visual "Pockets" view separating statement balances from unbilled, ongoing credit card exposures.
Deploy the local push notification fallback system to catch unparsed text strings and route them into the Parse_Failures manual override view.
🔒 Security & Data Compliance Mandate
Absolute Redaction: The local strategy parsers are fundamentally restricted from tracking, processing, or logging confidential security strings including account passwords, Multi-Factor Authentication hashes, One-Time Passwords (OTPs), or full credit card sequence arrays.
Zero Network Traffic: The networking layer is locked in the source configuration. No tracking metrics or financial aggregates are allowed to route to cloud environments.
Developed with 💚 by Product Owners and Engineers driving localized financial security.