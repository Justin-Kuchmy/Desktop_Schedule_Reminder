#!/bin/bash

# Log when the scheduler starts
echo "Scheduler started at $(date)" >> ~/Scheduler.log

# Track the currently active task
CURRENT_TASK="No current task"
echo "$CURRENT_TASK" > ~/current_reminder.txt

# Run forever, checking time every minute
while true; do
    # Get current hour and minute
    Hr=$(date "+%H")
    Min=$(date "+%M")

    # Holds the task for the current time
    NEW_TASK=""

    # Night / sleep time
    if [ "$Hr" -gt 22 ] || { [ "$Hr" -eq 22 ] && [ "$Min" -ge 30 ]; }; then
        NEW_TASK="10:30 PM — Time for sleep"

    # Evening free time
    elif [ "$Hr" -gt 21 ] || { [ "$Hr" -eq 21 ] && [ "$Min" -ge 0 ]; }; then
        NEW_TASK="9:00 PM — Free time"

    # Gaming time
    elif [ "$Hr" -gt 19 ] || { [ "$Hr" -eq 19 ] && [ "$Min" -ge 0 ]; }; then
        NEW_TASK="7:00 PM — Gaming"

    # Dinner time
    elif [ "$Hr" -gt 18 ] || { [ "$Hr" -eq 18 ] && [ "$Min" -ge 0 ]; }; then
        NEW_TASK="6:00 PM — Dinner"

    # Afternoon programming session
    elif [ "$Hr" -gt 14 ] || { [ "$Hr" -eq 14 ] && [ "$Min" -ge 0 ]; }; then
        NEW_TASK="2:00 PM — Programming (JustPay App)"

    # Lunch break
    elif [ "$Hr" -gt 13 ] || { [ "$Hr" -eq 13 ] && [ "$Min" -ge 0 ]; }; then
        NEW_TASK="1:00 PM — Lunch"

    # Gym time
    elif [ "$Hr" -gt 12 ] || { [ "$Hr" -eq 12 ] && [ "$Min" -ge 0 ]; }; then
        NEW_TASK="12:00 PM — Gym"

    # Morning programming session
    elif [ "$Hr" -gt 10 ] || { [ "$Hr" -eq 10 ] && [ "$Min" -ge 30 ]; }; then
        NEW_TASK="10:30 AM — Programming (JustPay App)"

    # Learning time
    elif [ "$Hr" -gt 9 ] || { [ "$Hr" -eq 9 ] && [ "$Min" -ge 0 ]; }; then
        NEW_TASK="9:00 AM — LinkedIn Learning"

    # No scheduled task
    else
        NEW_TASK="No current task"
    fi

    # Only update if the task changed
    if [ "$NEW_TASK" != "$CURRENT_TASK" ]; then
        CURRENT_TASK="$NEW_TASK"
        echo "$CURRENT_TASK" > ~/current_reminder.txt

        # Send a notification if there is an active task
        if [ "$CURRENT_TASK" != "No current task" ]; then
            notify-send "Reminder" "$CURRENT_TASK"
        fi

        # Log task changes
        echo "$(date): $CURRENT_TASK" >> ~/Scheduler.log
    fi

    # Wait one minute before checking again
    sleep 60
done
