# Day 6 - Baseline Hardening

## Objective

Apply basic system hardening before deploying services.

## Actions Performed

### System Update

Updated packages using `apt update && apt upgrade`.
Reason: fix vulnerabilities.

### User Verification

Checked sudo users.
No unauthorized users found.
Reason: prevent unauthorized access.

### Services Check

Listed running services.
Disabled unnecessary services.
Reason: reduce attack surface.

### Network Check

Verified open ports using `ss -tulpn`.
Only SSH (22) is active.
Reason: limit exposure.

### Time Configuration

Verified system time with `timedatectl`.
Timezone set correctly.
Reason: accurate logs.

### Logs Verification

Checked logs using `journalctl`.
No critical errors found.
Reason: system stability.

## Conclusion

The system is now:

- Updated
- Minimal
- Secure baseline ready for deployment

## Verification

- ✔ system updated
- ✔ no weird services
- ✔ ports minimal
- ✔ logs clean

## Point binôme

To Youssef:

> "عملت hardening، السيستام clean
> ما فما حتى حاجة تنجم تأثر على Docker"
