# GitHub Copilot Instructions for win32-event

## Purpose

This document defines the authoritative operational workflow for AI assistants contributing to the win32-event repository. The win32-event library provides an interface to Windows event objects for Ruby applications, enabling synchronization between threads through event signaling.

## Repository Structure

```
win32-event/
├── .expeditor/                    # Chef Expeditor automation configuration
│   ├── config.yml                 # Release and version management
│   ├── run_windows_tests.ps1      # Windows test execution script
│   ├── update_version.sh          # Version bumping script
│   └── verify.pipeline.yml        # Verification pipeline
├── .github/
│   ├── CODEOWNERS                 # Repository ownership definitions
│   ├── prompts/
│   │   └── generateinstructions.prompt.md  # AI instruction generation prompt
│   └── workflows/
│       ├── lint.yml               # RuboCop/Cookstyle linting workflow
│       └── unit.yml               # Unit tests on Windows platforms
├── .vscode/
│   └── mcp.json                   # VS Code MCP configuration
├── certs/
│   └── djberg96_pub.pem          # Gem signing certificate
├── lib/
│   ├── win32-event.rb            # Main library entry point
│   └── win32/
│       ├── event.rb              # Core Event class implementation
│       └── event/
│           └── version.rb        # Version constant definition
├── test/
│   ├── test_helper.rb            # Test configuration and utilities
│   └── test_win32_event.rb       # Unit tests for Event class
├── .rubocop.yml                  # Ruby style configuration
├── CHANGELOG.md                  # Version history and changes
├── CHANGES                       # Legacy change log
├── Gemfile                       # Ruby dependency management
├── MANIFEST                      # File listing for gem packaging
├── Rakefile                      # Build and test automation
├── README                        # Project documentation
├── VERSION                       # Current version number
└── win32-event.gemspec          # Gem specification
```

## Tooling & Ecosystem

- **Language**: Ruby (>= 3.1)
- **Platform**: Windows-specific (Windows 2022, Windows 2025)
- **Dependencies**: win32-ipc (>= 0.7.0), fiddle (= 1.1.6)
- **Testing**: test-unit framework
- **Linting**: Cookstyle (ChefStyle configuration)
- **Build Tool**: Rake
- **Package Manager**: RubyGems
- **CI/CD**: GitHub Actions + Chef Expeditor
- **Version Management**: Semantic versioning with Expeditor automation

## Issue (Jira/Tracker) Integration

This repository does not currently integrate with Jira or external issue trackers. Issues are managed through GitHub Issues. When working with GitHub issues:

1. Reference issue numbers in commit messages: `(#123)`
2. Use GitHub's linking syntax: `Fixes #123`, `Closes #123`, `Resolves #123`
3. For external issue trackers (if introduced), follow this pattern:
   - Parse: summary, description, acceptance criteria, issue type, linked issues, labels, story points
   - Create implementation plan before coding
   - Require user approval with explicit "yes" confirmation

Implementation Plan Template (when applicable):

- **Goal**: Clear objective statement
- **Impacted Files**: List of files to be modified
- **Public API Changes**: Any breaking or additive API changes
- **Data/Integration Considerations**: Windows API compatibility, platform-specific concerns
- **Test Strategy**: Test coverage approach for Windows-specific functionality
- **Edge Cases**: Platform variations, permission issues, concurrent access
- **Risks & Mitigations**: Compatibility, performance, security considerations
- **Rollback Strategy**: Specific revert steps

## Workflow Overview

AI MUST follow these phases in order:

1. **Intake & Clarify** - Understand requirements and scope
2. **Repository Analysis** - Examine current codebase and context
3. **Plan Draft** - Create detailed implementation plan
4. **Plan Confirmation** - Wait for explicit user "yes" approval
5. **Incremental Implementation** - Small, cohesive changes
6. **Lint / Style** - Cookstyle compliance verification
7. **Test & Coverage Validation** - Windows-specific testing
8. **DCO Commit** - Developer Certificate of Origin compliance
9. **Push & Draft PR Creation** - Create draft pull request
10. **Label & Risk Application** - Apply appropriate GitHub labels
11. **Final Validation** - Comprehensive check before completion

Each phase ends with: Step Summary + Checklist + "Continue to next step? (yes/no)"

## Detailed Step Instructions

Principles (MUST follow):

- Smallest cohesive change per commit
- Add/adjust tests immediately with each behavior change
- Present mapping of changes to tests before committing
- Ensure Windows platform compatibility
- Maintain FFI/Fiddle integration integrity

Example Step Output:

```
Step: Add boundary guard in event creation
Summary: Added nil check & size constraint; tests added for empty input & overflow scenarios.
Checklist:
- [x] Plan
- [x] Implementation  
- [ ] Tests
- [ ] Windows validation
Proceed? (yes/no)
```

If user responds other than explicit "yes" → AI MUST pause & clarify.

## Branching & PR Standards

**Branch Naming** (MUST):

- With issue: Use EXACT issue key if provided
- Without issue: kebab-case slug (≤40 chars) derived from task description
- Examples: `fix-event-memory-leak`, `add-timeout-support`

**Branch Scope**: One logical change set per branch (MUST)

**PR Requirements**:

- Remain draft until: tests pass + lint passes + coverage mapping complete
- Target `main` branch (current release branch)
- Include platform-specific test validation on Windows

**PR Description Sections** (MUST include, HTML format):

- **Summary**: What and why
- **Issue**: Link to GitHub issue or external tracker
- **Changes**: Bulleted list of modifications
- **Tests & Coverage**: Coverage mapping and platform validation
- **Risk & Mitigations**: Risk classification and rollback strategy
- **DCO**: Confirmation of Developer Certificate of Origin compliance

**Risk Classification** (MUST select one):

- **Low**: Localized, non-breaking changes
- **Moderate**: Shared module or light interface changes
- **High**: Public API changes, performance impacts, security implications, Windows API changes

**Rollback Strategy** (MUST provide): `revert commit <SHA>` or feature toggle reference

## Commit & DCO Policy

**Commit Format** (MUST follow):

```
{{TYPE}}({{OPTIONAL_SCOPE}}): {{SUBJECT}} ({{ISSUE_KEY}})

{{RATIONALE_DESCRIPTION}}

Issue: {{ISSUE_KEY or none}}
Signed-off-by: {{FULL_NAME}} <{{EMAIL}}>
```

**Types**: feat, fix, docs, style, refactor, test, chore
**Scopes**: event, version, test, ci, release
**Examples**:

- `feat(event): add timeout parameter support (#123)`
- `fix(test): resolve Windows permission test failures (#124)`
- `chore(ci): update Windows runner versions (#125)`

Missing sign-off → AI MUST request user name/email and block commit.

## Testing & Coverage

**Changed Logic → Test Assertions Mapping** (MUST provide):

| File | Method/Block | Change Type | Test File | Assertion Reference |
|------|--------------|-------------|-----------|-------------------|
| lib/win32/event.rb | initialize | Added timeout | test/test_win32_event.rb | test_timeout_initialization |

**Coverage Threshold** (MUST achieve): ≥80% changed lines

**Edge Cases** (MUST enumerate for each plan):

- **Windows Versions**: Compatibility across Windows 2022, Windows 2025
- **Permissions**: User/admin privilege variations
- **Concurrency**: Multi-threaded event access
- **Memory**: Large-scale event creation/destruction
- **Platform**: x86 vs x64 architecture differences
- **Dependencies**: win32-ipc version compatibility
- **Error Conditions**: Invalid event names, system resource limits

**Windows-Specific Testing**: All tests must pass on both Windows 2022 and Windows 2025 in CI.

## Labels Reference

| Name | Description | Typical Use |
|------|-------------|-------------|
| Aspect: Documentation | How do we use this project? | README, API docs, examples |
| Aspect: Integration | Works correctly with other projects or systems | win32-ipc compatibility |
| Aspect: Packaging | Distribution of compiled artifacts | Gem packaging, certs |
| Aspect: Performance | Works without negatively affecting system | Memory, speed optimizations |
| Aspect: Portability | Works correctly on specified platform | Windows version compatibility |
| Aspect: Security | Prevents unwanted third party access | Permission handling, validation |
| Aspect: Stability | Consistent results | Thread safety, error handling |
| Aspect: Testing | Good coverage and working CI | Test improvements, CI fixes |
| Platform: Windows | Windows-specific changes | Core platform functionality |
| Expeditor: Bump Version Major | Major version bump (breaking changes) | API breaking changes |
| Expeditor: Bump Version Minor | Minor version bump (new features) | New functionality |
| Expeditor: Skip All | Skip all merge actions | Emergency or special circumstances |
| Expeditor: Skip Changelog | Skip changelog update | Version bumps without changelog |
| Expeditor: Skip Version Bump | Skip version increment | Documentation-only changes |
| hacktoberfest-accepted | Accepted Hacktoberfest contribution | Community contributions |
| oss-standards | OSS Repository Standardization | Repository maintenance |

## CI / Release Automation Integration

**GitHub Actions Workflows**:

- **unit.yml**: Unit tests on Windows 2022/2025 with Ruby 3.1/3.4 matrix
  - Triggers: pull_request, push to master
  - Jobs: test execution with bundler cache
- **lint.yml**: Cookstyle linting with ChefStyle configuration  
  - Triggers: pull_request, push to main
  - Jobs: RuboCop problem matchers integration

**Chef Expeditor Automation**:

- **Release Management**: Automated version bumping, changelog updates, gem building
- **Version Tagging**: Format `win32-event-{{version}}`
- **RubyGems Publishing**: Automated publishing to rubygems.org
- **Slack Notifications**: chef-notify channel for build failures

**Version Bump Mechanism**:

- Expeditor label-driven (`Expeditor: Bump Version Minor/Major`)
- Semantic versioning with 0.* constraint on main branch
- Automated via `.expeditor/update_version.sh`

**AI MUST NOT** directly edit release automation configs without explicit user instruction.

## Security & Protected Files

**Protected Files** (NEVER edit without explicit approval):

- `certs/djberg96_pub.pem` - Gem signing certificate
- `.expeditor/config.yml` - Release automation
- `.github/workflows/*.yml` - CI configuration  
- `.github/CODEOWNERS` - Repository ownership
- `LICENSE` files (if present)
- Security or compliance documentation

**Security Constraints** (NEVER):

- Exfiltrate or inject secrets
- Force-push to default branch
- Merge PR autonomously
- Insert new binaries without approval
- Remove license headers
- Fabricate issue or label data
- Reference `~/.profile` in authentication guidance
- Modify Windows API integration without security review

## Prompts Pattern (Interaction Model)

After each step, AI MUST output:

```
Step: {{STEP_NAME}}
Summary: {{CONCISE_OUTCOME}}
Checklist: 
- [x] {{COMPLETED_ITEM}}
- [ ] {{PENDING_ITEM}}
Prompt: "Continue to next step? (yes/no)"
```

Non-affirmative response → AI MUST pause & clarify before proceeding.

## Validation & Exit Criteria

Task is COMPLETE ONLY IF:

1. ✅ Feature/fix branch exists & pushed
2. ✅ Cookstyle linting passes
3. ✅ Tests pass on Windows 2022 and Windows 2025
4. ✅ Coverage mapping complete + ≥80% changed lines
5. ✅ PR open (draft or ready) with required HTML sections
6. ✅ Appropriate labels applied from repository set
7. ✅ All commits DCO-compliant with proper sign-off
8. ✅ No unauthorized Protected File modifications
9. ✅ Windows platform compatibility verified
10. ✅ User explicitly confirms completion
11. ✅ Revision History updated (if updating existing instructions)

Otherwise, AI MUST list unmet items and cannot declare completion.

## Issue Planning Template

```
Issue: {{ISSUE_KEY}}
Summary: {{ISSUE_SUMMARY}}
Acceptance Criteria:
- {{CRITERIA_1}}
- {{CRITERIA_2}}

Implementation Plan:
- **Goal**: {{CLEAR_OBJECTIVE}}
- **Impacted Files**: {{FILE_LIST}}
- **Public API Changes**: {{API_CHANGES_OR_NONE}}
- **Data/Integration Considerations**: {{WINDOWS_API_CONCERNS}}
- **Test Strategy**: {{TESTING_APPROACH}}
- **Edge Cases**: {{PLATFORM_EDGE_CASES}}
- **Risks & Mitigations**: {{RISK_ANALYSIS}}
- **Rollback**: {{ROLLBACK_STRATEGY}}

Proceed? (yes/no)
```

## PR Description Canonical Template

Since no pull request template exists in the repository, use this format:

```html
<h2>Summary</h2>
<p>{{WHAT_AND_WHY}}</p>

<h2>Issue</h2>
<p><a href="{{ISSUE_URL}}">{{ISSUE_KEY}}</a></p>

<h2>Changes</h2>
<ul>
<li>Modified: {{FILE_OR_COMPONENT}}</li>
<li>Added: {{NEW_FUNCTIONALITY}}</li>
</ul>

<h2>Tests & Coverage</h2>
<p>Changed lines: {{N}}; Estimated covered: ~{{X}}%; Windows platform validation complete.</p>

<h2>Risk & Mitigations</h2>
<p>Risk: {{LOW|MODERATE|HIGH}} | Mitigation: {{ROLLBACK_STRATEGY}}</p>

<h2>DCO</h2>
<p>All commits signed off with Developer Certificate of Origin.</p>
```

## Idempotency Rules

**Re-entry Detection Order** (MUST check):

1. Branch existence: `git rev-parse --verify {{branch}}`
2. PR existence: `gh pr list --head {{branch}}`
3. Uncommitted changes: `git status --porcelain`
4. Existing Revision History block in this file

**Delta Summary** (MUST document when updating):

- **Added Sections**: {{NEW_SECTIONS}}
- **Modified Sections**: {{CHANGED_SECTIONS}}  
- **Deprecated Sections**: {{REMOVED_SECTIONS}}
- **Rationale**: {{WHY_CHANGED}}

## Failure Handling

**Decision Tree** (MUST follow):

- **Labels fetch fails** → Abort; prompt: "Provide label list manually or fix auth. Retry? (yes/no)"
- **Issue fetch incomplete** → Ask: "Missing acceptance criteria—provide or proceed with inferred? (provide/proceed)"
- **Coverage < threshold** → Add tests; re-run; block commit until satisfied
- **Windows tests fail** → Platform-specific debugging required; investigate Windows compatibility
- **Missing DCO** → Request user name/email for sign-off
- **Protected file modification attempt** → Reject & restate policy
- **Expeditor conflict** → Check for conflicting automation; pause for resolution

## Glossary

- **Changed Lines Coverage**: Portion of modified lines executed by test assertions
- **Implementation Plan Freeze Point**: No code changes allowed until user approval
- **Protected Files**: Policy-restricted assets requiring explicit authorization
- **Idempotent Re-entry**: Resuming workflow without duplicated or conflicting state
- **Risk Classification**: Qualitative impact assessment (Low/Moderate/High)
- **Rollback Strategy**: Concrete reversal action (revert commit/disable feature)
- **DCO**: Developer Certificate of Origin sign-off confirming contribution rights
- **Expeditor**: Chef's automation platform for release management
- **Cookstyle**: Chef's Ruby style checker based on RuboCop

## Quick Reference Commands

```bash
# Repository setup
git clone https://github.com/chef/win32-event.git
cd win32-event
bundle install

# Development workflow
git checkout -b {{BRANCH_NAME}}
bundle exec rake test          # Run tests
bundle exec cookstyle --chefstyle -c .rubocop.yml  # Lint
git add .
git commit -m "{{TYPE}}({{SCOPE}}): {{SUBJECT}} ({{ISSUE}})" \
           -m "{{RATIONALE}}" \
           -m "Issue: {{ISSUE_OR_NONE}}" \
           -m "Signed-off-by: {{NAME}} <{{EMAIL}}>"
git push -u origin {{BRANCH_NAME}}

# PR management
gh pr create --base main --head {{BRANCH_NAME}} --title "{{TITLE}}" --draft
gh pr edit {{PR_NUMBER}} --add-label "{{LABEL}}"
gh pr ready {{PR_NUMBER}}  # Mark ready when complete

# Testing on Windows
bundle exec rake test
# Expeditor will handle cross-platform validation in CI
```

## AI-Assisted Development & Compliance

- ✅ Create PR with `ai-assisted` label (if label doesn't exist, create it with description "Work completed with AI assistance following Progress AI policies" and color "9A4DFF")
- ✅ Include "This work was completed with AI assistance following Progress AI policies" in PR description

### Jira Ticket Updates (MANDATORY)

- ✅ **IMMEDIATELY after PR creation**: Update Jira ticket custom field `customfield_11170` ("Does this Work Include AI Assisted Code?") to "Yes"
- ✅ Use atlassian-mcp tools to update the Jira field programmatically
- ✅ **CRITICAL**: Use correct field format: `{"customfield_11170": {"value": "Yes"}}`
- ✅ Verify the field update was successful

### Documentation Requirements

- ✅ Reference AI assistance in commit messages where appropriate
- ✅ Document any AI-generated code patterns or approaches in PR description
- ✅ Maintain transparency about which parts were AI-assisted vs manual implementation

### Workflow Integration

This AI compliance checklist should be integrated into the main development workflow Step 4 (Pull Request Creation):

```
Step 4: Pull Request Creation & AI Compliance
- Step 4.1: Create branch and commit changes WITH SIGNED-OFF COMMITS
- Step 4.2: Push changes to remote
- Step 4.3: Create PR with ai-assisted label
- Step 4.4: IMMEDIATELY update Jira customfield_11170 to "Yes"
- Step 4.5: Verify both PR labels and Jira field are properly set
- Step 4.6: Provide complete summary including AI compliance confirmation
```

- **Never skip Jira field updates** - This is required for Progress AI governance
- **Always verify updates succeeded** - Check response from atlassian-mcp tools
- **Treat as atomic operation** - PR creation and Jira updates should happen together
- **Double-check before final summary** - Confirm all AI compliance items are completed

### Audit Trail

All AI-assisted work must be traceable through:

1. GitHub PR labels (`ai-assisted`)
2. Jira custom field (`customfield_11170` = "Yes")
3. PR descriptions mentioning AI assistance
4. Commit messages where relevant

---
