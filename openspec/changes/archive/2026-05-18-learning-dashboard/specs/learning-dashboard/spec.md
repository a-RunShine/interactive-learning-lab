## ADDED Requirements

### Requirement: Dashboard SHALL display session history
`dashboard.html` SHALL load `dashboard-data.json` and display each learning session as a card with topic name, date, module progress, and error count.

#### Scenario: Viewing session cards
- **WHEN** user opens dashboard.html and dashboard-data.json exists with sessions
- **THEN** each session SHALL be displayed as a card showing topic, date, module progress bars, and error count

### Requirement: Dashboard SHALL display error log
`dashboard.html` SHALL show a dedicated error log section listing all recorded errors with error message, module context, root cause, and resolution.

#### Scenario: Viewing error entries
- **WHEN** user scrolls to the error log section
- **THEN** each error SHALL be displayed with error message, originating module, root cause analysis, and fix description

### Requirement: Data file SHALL be written by agent after teaching
The teach-anything skill SHALL append session data to `dashboard-data.json` at the end of each teaching session.

#### Scenario: Session data appended
- **WHEN** a teaching session completes (all modules done or user exits)
- **THEN** agent SHALL append the session's topic, module list with completion status, and error log to `dashboard-data.json`

### Requirement: Dashboard SHALL be a zero-dependency single HTML file
`dashboard.html` SHALL contain all CSS and JavaScript inline, with no external dependencies.

#### Scenario: Opening in browser
- **WHEN** user opens dashboard.html in a browser
- **THEN** it SHALL render correctly without network access, using only embedded styles and scripts
