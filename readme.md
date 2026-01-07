# Mikrotik CHR & Ansible Automation Assessment

## Project Overview
This repository contains the deliverables for the Network Support Engineer technical assessment. The objective was to configure a Mikrotik CHR, secure it via firewall, and automate RADIUS client provisioning using Ansible.

## Repository Structure
* **AnsiblePlaybook/**: Contains the `RADIUS.yml` playbook used for automation.
* **Screenshots/**: Verification images (`Firewall.png`, `Ansible.png`, `RADIUS.png`).
* **hosts**: The Ansible inventory file containing connection parameters.
* **chr.rsc**: The exported configuration of the Mikrotik router.

---

## 1. Steps Taken to Complete the Task

### Step 1: Virtualization Setup
* Deployed Mikrotik CHR (Cloud Hosted Router) on Oracle VirtualBox.
* Configured the network adapter to "Bridged" mode to allow local network access.
* Verified connectivity by accessing the router via Winbox.

### Step 2: Security Configuration
* Accessed the router using Winbox.
* Created a Firewall Filter Rule in the `forward` chain.
* Action set to `drop` for traffic destined to `1.1.1.1` on TCP port `443`.

### Step 3: Automation with Ansible
* Installed Ansible and the `community.routeros` collection on a WSL 2 (Ubuntu) environment.
* Created an inventory file (`hosts`) defining the Mikrotik connection parameters.
* Developed the `RADIUS.yml` playbook to define a RADIUS client pointing to `35.227.71.209`.
* Executed the playbook and verified the configuration change in Winbox.

### Step 4: Hotspot & Export
* Added a secondary network interface (`ether2`) to the VM.
* Configured a local Hotspot service on the new interface.
* Exported the full system configuration to `chr.rsc`.

---

## 2. Challenges Encountered

### Ansible on Windows
**Challenge:** Ansible is not natively supported on Windows, which prevented direct installation via PowerShell.
**Solution:** I installed Windows Subsystem for Linux (WSL 2) to run a native Ubuntu environment, allowing Ansible to function correctly.

### WSL Virtualization Error
**Challenge:** Encountered error `0x80370114` when initializing WSL, indicating the Virtual Machine Platform was disabled.
**Solution:** Enabled "Virtual Machine Platform" via DISM commands and confirmed Virtualization Technology (VT-x) was enabled in the system BIOS.

### SSH Authentication
**Challenge:** The initial Ansible run failed due to authentication errors (`paramiko` and password rejection).
**Solution:**
1.  Installed the missing `python3-paramiko` library in the Linux environment.
2.  Set a dedicated password for the Mikrotik `admin` user (replacing the default blank password) to satisfy SSH security requirements.

---

## 3. References & Resources
* **Mikrotik Wiki:** Consulted for firewall filter syntax and CHR setup details.
* **Microsoft Learn:** Used for troubleshooting WSL 2 installation and hypervisor errors.
* **Ansible Documentation:** Referenced for the `community.routeros` module syntax.
* **Google Gemini:** Utilized for real-time troubleshooting of Ansible error logs and configuration verification.