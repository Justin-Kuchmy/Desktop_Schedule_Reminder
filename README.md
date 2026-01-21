
# Desktop Schedule Reminder

A lightweight desktop schedule reminder using a **Bash script** and **Conky**.

The Bash script tracks the current task based on time and writes it to a text file. Conky reads that file and displays the reminder on your desktop.

---

## What This Project Does

* Runs a background Bash scheduler
* Updates `current_reminder.txt` with the current task
* Displays the task on your desktop using Conky
* Starts automatically on login

---

## Files

* `Scheduler.sh` – Main Bash scheduler script
* `scheduler.conf` – Conky configuration file
* `current_reminder.txt` – Generated file used by Conky (created automatically)

---

## Requirements

* Linux desktop environment
* Bash
* Conky
* `notify-send` (usually included via `libnotify`)

---

## Installing Conky

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install conky-all
```

### Arch Linux

```bash
sudo pacman -S conky
```

### Fedora

```bash
sudo dnf install conky
```

---

## Setup

### 1. Clone the Repository

```bash
git clone git@github.com:Justin-Kuchmy/Desktop_Schedule_Reminder.git
cd Desktop_Schedule_Reminder
```

---

### 2. Make the Scheduler Executable

```bash
chmod +x Scheduler.sh
```

---

### 3. Place the Conky Config

Create the Conky config directory if it doesn’t exist:

```bash
mkdir -p ~/.config/conky
```

Copy the config file:

```bash
cp scheduler.conf ~/.config/conky/scheduler.conf
```

---

### 4. Test Manually

Run the scheduler:

```bash
./Scheduler.sh &
```

Start Conky:

```bash
conky -c ~/.config/conky/scheduler.conf &
```

You should now see your current task displayed on the desktop.

---

## Running Automatically on Startup

### Option A: Desktop Startup Applications (Recommended)

Most desktop environments support startup programs.

Add **two startup entries**:

**Scheduler**

```text
Command: /full/path/to/Scheduler.sh
```

**Conky**

```text
Command: conky -c /home/USERNAME/.config/conky/scheduler.conf
```

Make sure to use full paths.

---

### Option B: systemd User Service (Advanced)

Create the scheduler service:

```bash
mkdir -p ~/.config/systemd/user
nano ~/.config/systemd/user/scheduler.service
```

```ini
[Unit]
Description=Desktop Schedule Scheduler

[Service]
ExecStart=/full/path/to/Scheduler.sh
Restart=always

[Install]
WantedBy=default.target
```

Enable it:

```bash
systemctl --user daemon-reload
systemctl --user enable --now scheduler.service
```

Conky can still be started via startup applications.

---

## Notes

* `current_reminder.txt` is automatically created in your home directory
* Conky refreshes every 5 seconds
* The scheduler updates once per minute
* Notifications are only sent when the task changes

---

## Customization

* Edit the schedule directly inside `Scheduler.sh`
* Adjust Conky position and transparency in `scheduler.conf`
* Change fonts, colors, or alignment as desired

---

## License

MIT License

---

## Why This Exists

This project is intentionally simple:

* No heavy dependencies
* Easy to understand
* Easy to modify

It’s designed as a personal productivity tool and a clean example of practical Bash automation.
