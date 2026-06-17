import Cocoa
import EventKit

// Reusable EventKit helper template for Apple Calendar creation from Hermes.
// Customize: logPath, calendarName, event fields, duplicate predicate, alarms.

let logPath = "/tmp/hermes_calendar_event.log"
func log(_ message: String) {
    let line = "\(Date()): \(message)\n"
    guard let data = line.data(using: .utf8) else { return }
    if FileManager.default.fileExists(atPath: logPath),
       let handle = try? FileHandle(forWritingTo: URL(fileURLWithPath: logPath)) {
        try? handle.seekToEnd()
        try? handle.write(contentsOf: data)
        try? handle.close()
    } else {
        try? data.write(to: URL(fileURLWithPath: logPath))
    }
}

let store = EKEventStore()
let sem = DispatchSemaphore(value: 0)
var granted = false
var requestError: Error? = nil

if #available(macOS 14.0, *) {
    store.requestFullAccessToEvents { ok, err in
        granted = ok
        requestError = err
        sem.signal()
    }
} else {
    store.requestAccess(to: .event) { ok, err in
        granted = ok
        requestError = err
        sem.signal()
    }
}

let waitResult = sem.wait(timeout: .now() + 120)
log("Calendar access: wait=\(waitResult == .success ? "success" : "timedout") granted=\(granted) error=\(String(describing: requestError))")
guard granted else { exit(2) }

let calendarName = "Family" // customize
let calendars = store.calendars(for: .event)
for cal in calendars {
    log("Calendar: \(cal.title) source=\(cal.source.title) modify=\(cal.allowsContentModifications) id=\(cal.calendarIdentifier)")
}

guard let targetCalendar = calendars.first(where: {
    $0.allowsContentModifications && $0.title.trimmingCharacters(in: .whitespacesAndNewlines).caseInsensitiveCompare(calendarName) == .orderedSame
}) ?? calendars.first(where: {
    $0.allowsContentModifications && $0.title.localizedCaseInsensitiveContains(calendarName)
}) else {
    log("ERROR: No modifiable calendar matched \(calendarName)")
    exit(3)
}

var comps = DateComponents()
comps.calendar = Calendar.current
comps.timeZone = TimeZone.current
comps.year = 2026       // customize
comps.month = 1         // customize
comps.day = 1           // customize
comps.hour = 9          // customize
comps.minute = 0        // customize
guard let start = comps.date else { log("ERROR: invalid date"); exit(4) }
let end = start.addingTimeInterval(60 * 60) // customize duration

let duplicatePredicate = store.predicateForEvents(
    withStart: start.addingTimeInterval(-3600),
    end: end.addingTimeInterval(3600),
    calendars: [targetCalendar]
)
let duplicate = store.events(matching: duplicatePredicate).first { event in
    event.title.localizedCaseInsensitiveContains("CUSTOMIZE TITLE TOKEN")
    // Add stable location/date checks when available.
}
if let duplicate {
    log("Existing matching event found; not creating duplicate. id=\(duplicate.eventIdentifier ?? "nil") title=\(duplicate.title ?? "nil") start=\(String(describing: duplicate.startDate))")
    exit(0)
}

let event = EKEvent(eventStore: store)
event.calendar = targetCalendar
event.title = "CUSTOMIZE TITLE"
event.startDate = start
event.endDate = end
event.location = "CUSTOMIZE LOCATION"
event.notes = "CUSTOMIZE NOTES"
event.url = URL(string: "https://example.com")
event.addAlarm(EKAlarm(relativeOffset: -30 * 60))

do {
    try store.save(event, span: .thisEvent, commit: true)
    log("SAVED id=\(event.eventIdentifier ?? "nil") title=\(event.title ?? "nil") start=\(String(describing: event.startDate)) end=\(String(describing: event.endDate)) calendar=\(targetCalendar.title)")
    exit(0)
} catch {
    log("ERROR saving event: \(error)")
    exit(5)
}

/*
Build as an app bundle so macOS can show a Calendar permission prompt with usage text:

rm -rf /tmp/HermesCalendarHelper.app
mkdir -p /tmp/HermesCalendarHelper.app/Contents/MacOS
swiftc /tmp/HermesCalendarHelper.swift -o /tmp/HermesCalendarHelper.app/Contents/MacOS/HermesCalendarHelper
/usr/libexec/PlistBuddy -c 'Clear dict' \
  -c 'Add :CFBundleIdentifier string com.hermes.calendarhelper' \
  -c 'Add :CFBundleName string HermesCalendarHelper' \
  -c 'Add :CFBundleExecutable string HermesCalendarHelper' \
  -c 'Add :CFBundlePackageType string APPL' \
  -c 'Add :LSUIElement bool true' \
  -c 'Add :NSCalendarsUsageDescription string Hermes needs calendar access to create the requested event.' \
  -c 'Add :NSCalendarsFullAccessUsageDescription string Hermes needs full calendar access to create the requested event.' \
  /tmp/HermesCalendarHelper.app/Contents/Info.plist
codesign --force --deep --sign - /tmp/HermesCalendarHelper.app
open -W /tmp/HermesCalendarHelper.app
cat /tmp/hermes_calendar_event.log
*/
