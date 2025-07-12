# alpine-init script

This simple script is designed to help you quickly set up Alpine Linux as a server environment.
## Included Base Packages
In my opnion and experience, these are the most basic packages that you need to have in your server environment.

- **nano** – simple text editor
- **vim** – advanced text editor
- **curl** – command-line tool for transferring data
- **wget** – network downloader
- **ufw** – uncomplicated firewall
- **htop** – interactive process viewer
- **gzip** – compression utility  
- **dcron**– lightweight cron daemon
## Tested Environment
- **Alpine Linux version:** 3.22
- **Container type:** LXC
- **Host platform:** Proxmox VM server
## Usage Instructions
Before running the script, ensure that `bash` is installed. If you plan to clone the repository, you will also need `git`.
### Quick Start
1. **Install prerequisites:**
```bash
apk add bash git
```
2. **Clone the repository:**
```bash
git clone https://github.com/d3m0k1d/automation-scripts.git
```
3. **Navigate to the script directory:**
```bash
cd automation-scripts/scripts/sysadmins
```
4. **Make the script executable:**
```bash
chmod +x alpine-init.sh
```
5. **Run the script:**
```bash
./alpine-init.sh
```
## Additional Notes
- The script is intended for fresh Alpine Linux installations.
- You can modify the list of base packages to suit your specific needs.
- For best results, run the script with root privileges.
## Maintenance
This script and repository will be maintained and updated as needed to reflect new features, improvements, and additional scripts.

If you have suggestions or feedback, please contact me at [contact@d3m0k1d.ru](mailto:contact@d3m0k1d.ru).
