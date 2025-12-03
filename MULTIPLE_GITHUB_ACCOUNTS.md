# Multiple GitHub Accounts Setup

## ✅ New SSH Key Created!

A new SSH key has been generated for your second GitHub account.

---

## 🔑 Your New Public Key

**Copy this key to add to your second GitHub account:**

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEeLOfe7+E52ZEbPzEK7UA6UJEqvfiUL39CLLHghecxh github-account2-20251203
```

---

## 📋 Step 1: Add Key to Second GitHub Account

1. **Log in to your second GitHub account**
2. **Go to SSH Settings:**
   - Visit: https://github.com/settings/keys
   - Or: Profile → Settings → SSH and GPG keys

3. **Add New SSH Key:**
   - Click "New SSH key"
   - **Title:** Give it a descriptive name (e.g., "MacBook - Account 2")
   - **Key type:** Authentication Key
   - **Key:** Paste the public key above
   - Click "Add SSH key"

---

## 🔧 Step 2: SSH Configuration

Your SSH config has been updated to support multiple accounts:

**Primary Account (existing):**
- Uses: `git@github.com`
- Key: `~/.ssh/fd-github`

**Secondary Account (new):**
- Uses: `git@github-account2`
- Key: `~/.ssh/id_ed25519_github_account2`

---

## 🚀 Step 3: How to Use

### For Primary GitHub Account:
```bash
# Clone repositories normally
git clone git@github.com:username/repo.git

# Push/pull works as usual
git push origin main
```

### For Secondary GitHub Account:
```bash
# Clone using the alias
git clone git@github-account2:username/repo.git

# Or change remote URL in existing repo
git remote set-url origin git@github-account2:username/repo.git
```

---

## ✅ Step 4: Test Both Accounts

### Test Primary Account:
```bash
ssh -T git@github.com
```
Expected: `Hi username1! You've successfully authenticated...`

### Test Secondary Account:
```bash
ssh -T git@github-account2
```
Expected: `Hi username2! You've successfully authenticated...`

---

## 📝 Managing Existing Repositories

If you have existing repositories that need to use the second account:

```bash
# Check current remote URL
git remote -v

# Change to use second account
git remote set-url origin git@github-account2:username/repo.git

# Verify
git remote -v
```

---

## 🔍 Key Locations

**Primary Account:**
- Private: `~/.ssh/fd-github`
- Public: `~/.ssh/fd-github.pub`

**Secondary Account:**
- Private: `~/.ssh/id_ed25519_github_account2`
- Public: `~/.ssh/id_ed25519_github_account2.pub`

---

## 🎯 Quick Reference

**View public keys:**
```bash
# Primary account
cat ~/.ssh/fd-github.pub

# Secondary account
cat ~/.ssh/id_ed25519_github_account2.pub
```

**Test connections:**
```bash
# Primary
ssh -T git@github.com

# Secondary
ssh -T git@github-account2
```

**View SSH config:**
```bash
cat ~/.ssh/config
```

---

## 💡 Tips

1. **Remember the alias:** Use `github-account2` instead of `github.com` for the second account
2. **Check before cloning:** Make sure you're using the right host alias
3. **Update remotes:** If you cloned with the wrong account, just update the remote URL
4. **Git config:** You can set different git user.name and user.email per repository:
   ```bash
   git config user.name "Your Name"
   git config user.email "your-email@example.com"
   ```

---

## 🐛 Troubleshooting

### "Permission denied" for second account
- Make sure you added the **public key** to the second GitHub account
- Verify the SSH config is correct
- Test with: `ssh -vT git@github-account2`

### Wrong account used
- Check remote URL: `git remote -v`
- Update if needed: `git remote set-url origin git@github-account2:user/repo.git`

### Keys not loading
```bash
# Add keys to SSH agent
ssh-add ~/.ssh/id_ed25519_github_account2
ssh-add ~/.ssh/fd-github
```

---

## ✅ You're All Set!

You can now use both GitHub accounts seamlessly:
- **Primary:** `git@github.com`
- **Secondary:** `git@github-account2`

Just remember to use the correct host alias when cloning or updating remotes!

