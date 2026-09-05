# Realmroot Agent Identity and Private Access

For authenticated access to user data or a private capability, including read
access, always use the `realmroot` skill and the Agent's stable identity first.

1. Establish the Agent identity when it is not already known for the selected
   Realmroot deployment.
2. Reuse known Resource, Context, and approved authority. Refresh discovery
   only when the target or required scope is unknown, the deployment or Context
   changes, or authorization or credentials fail.
3. If a matching Resource exists and is authorized, execute as the Agent
   without requesting authority again.
4. If a matching Resource exists but is not connected or authorized, request
   only the scopes required by the task and use the
   Realmroot controller approval flow. Do not switch to the user's identity.
5. If exhaustive discovery finds no matching Resource Server, or the matching
   Resource Server has no matching Resource, explain the gap and ask whether
   the user authorizes using the user's identity.
6. Use a user's browser session, connector, OAuth token, API key, cookie, or
   other credential only after that explicit approval. Never fall back
   silently.

Public data, task-scoped local workspace files, and content supplied directly
by the user do not require Realmroot.
