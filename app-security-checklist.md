# Application Security Checklist - Day 08

## 1. Authentication

- **Risk:** Weak password handling or brute force
- **Mitigation:** Use bcrypt hashing, implement login rate limiting

## 2. Routes Protection

- **Risk:** Unauthorized access to sensitive endpoints (`/admin`)
- **Mitigation:** Add authentication and role-based access control

## 3. Environment Variables / Secrets

- **Risk:** Secrets exposed in code or GitHub
- **Mitigation:** Use `.env` files and never commit secrets

## 4. File Upload

- **Risk:** Upload of malicious files
- **Mitigation:** Restrict file types, limit size, rename uploads

## 5. Error Handling

- **Risk:** Detailed errors expose system info
- **Mitigation:** Use generic error messages

## 6. Security Headers

- **Risk:** Missing headers lead to XSS/clickjacking
- **Mitigation:** Add CSP, X-Frame-Options, X-Content-Type-Options

## 7. Logging

- **Risk:** Sensitive data in logs
- **Mitigation:** Mask passwords and tokens

## 8. Database Security

- **Risk:** SQL Injection
- **Mitigation:** Use parameterized queries / ORM

## 9. Exposed Ports

- **Risk:** Application ports exposed publicly
- **Mitigation:** Only expose via Nginx (80/443)
