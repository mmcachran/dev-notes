# Laravel

## Laravel Tinker Commands - User Management

This document contains ready-to-use `php artisan tinker` one-liners for managing user accounts (focused on McAchran users). All commands are designed to be run from your Laravel project root.

---

## 1. Check for User by Email

**Description:**  
Quickly retrieve and display a user record by email address.

**When to use:**  
Before making changes to verify the correct user exists.

```bash
php artisan tinker --execute="dd(User::where('email', '<email>')->first());"
```

**Shorter alternative:**
```bash
php artisan tinker --execute="dd(User::whereEmail('<email>')->first());"
```

**Expected output:**  
Dumps the full user object (or `null` if not found).

---

## 2. Update Role to Admin (Simple Column)

**Description:**  
Sets the `role` column directly on the users table.

**When to use:**  
Only if your application uses a simple string/enum `role` column (not a relationship).

```bash
php artisan tinker --execute="User::where('email', '<email>')->update(['role' => 'admin']); echo '✅ Role updated to admin';"
```

**Expected output:**  
`✅ Role updated to admin`

---

## 3. Add Admin Role via Relationship (Recommended)

**Description:**  
Properly attaches the "admin" role using the `roles()` relationship.

**When to use:**  
This is the correct method when `role` is defined as a many-to-many relationship (most modern Laravel apps).

### 3.1 Add Admin Role (without removing existing roles)

```bash
php artisan tinker --execute='$user=User::where("email","<email>")->firstOrFail(); $role=Role::where("name","admin")->firstOrFail(); $user->roles()->syncWithoutDetaching([$role->id]); echo "✅ Admin role added via relationship";'
```

**Expected output:**  
`✅ Admin role added via relationship`

### 3.2 Replace All Roles with Only "admin"

```bash
php artisan tinker --execute='$user=User::where("email","<email>")->firstOrFail(); $role=Role::where("name","admin")->firstOrFail(); $user->roles()->sync([$role->id]); echo "✅ Roles replaced with admin only";'
```

**Expected output:**  
`✅ Roles replaced with admin only`

### 3.3 Remove Admin Role

```bash
php artisan tinker --execute='$user=User::where("email","<email>")->firstOrFail(); $role=Role::where("name","admin")->firstOrFail(); $user->roles()->detach($role->id); echo "✅ Admin role removed";'
```

**Expected output:**  
`✅ Admin role removed`

---

## 4. Delete Both McAchran Accounts

**Description:**  
Deletes all users whose email or name contains "mcachran".

**When to use:**  
Cleaning up duplicate/test accounts.

### 4.1 Safe Preview (Recommended First Step)

```bash
php artisan tinker --execute="dd(User::where('email', 'like', '%mcachran%')->orWhere('name', 'like', '%mcachran%')->get(['id','name','email']));"
```

**Expected output:**  
Shows the list of users that would be deleted.

### 4.2 Delete Command

```bash
php artisan tinker --execute='$count = User::where("email","like","%mcachran%")->orWhere("name","like","%mcachran%")->delete(); echo "✅ Deleted {$count} mcachran account(s)";'
```

**Expected output:**  
`✅ Deleted 2 mcachran account(s)` (or however many matched)

### 4.3 Force Delete (for Soft Deletes)

```bash
php artisan tinker --execute='$count = User::where("email","like","%mcachran%")->orWhere("name","like","%mcachran%")->forceDelete(); echo "✅ Permanently deleted {$count} account(s)";'
```

---

## 5. Full Reset: Delete + Create Fresh Admin Account

**Description:**  
Deletes existing mcachran accounts, creates a brand new user, and assigns the admin role via relationship.

**When to use:**  
Complete reset of a user account (e.g. after testing or data issues).

```bash
php artisan tinker --execute='User::where("email","like","%mcachran%")->orWhere("name","like","%mcachran%")->delete(); $user=User::create(["name"=>"Matthew McAchran","email"=>"<email>","password"=>Hash::make("ChangeThisPassword123!")]); $role=Role::where("name","admin")->firstOrFail(); $user->roles()->syncWithoutDetaching([$role->id]); echo "✅ Done. New admin created: ".$user->email." (ID: ".$user->id.")";'
```

**Expected output:**  
`✅ Done. New admin created: <email> (ID: 123)`

> **Important:** Immediately change the password after running this command.

---

## 6. Update email_verified_at

**Description:**  
Controls the email verification timestamp on the user record.

### 6.1 Mark Email as Verified

```bash
php artisan tinker --execute='User::where("email", "<email>")->update(["email_verified_at" => now()]); echo "✅ email_verified_at updated to now()";'
```

**Expected output:**  
`✅ email_verified_at updated to now()`

### 6.2 Unverify Email (set to null)

```bash
php artisan tinker --execute='User::where("email", "<email>")->update(["email_verified_at" => null]); echo "✅ Email marked as unverified";'
```

### 6.3 Verify Email + Ensure Admin Role (Combined)

```bash
php artisan tinker --execute='User::where("email", "<email>")->update(["email_verified_at" => now()]); $user=User::where("email","<email>")->first(); $role=Role::where("name","admin")->firstOrFail(); $user->roles()->syncWithoutDetaching([$role->id]); echo "✅ Verified + Admin role ensured";'
```

---

## 7. Verification & Debugging Commands

### 7.1 Check Current Roles of a User

```bash
php artisan tinker --execute='$user=User::where("email","<email>")->first(); dd($user->roles()->pluck("name"));'
```

**Expected output:**  
Dumps a collection of role names, e.g. `["admin"]`

### 7.2 Full User Details

```bash
php artisan tinker --execute="dd(User::where('email', '<email>')->first());"
```

---

## Notes & Best Practices

- **Always preview before deleting** — Use the check/preview commands first.
- `syncWithoutDetaching()` is the safest method to add a role without removing other existing roles.
- After creating a new user with these commands, **change the password immediately**.
- These commands assume:
  - Standard `User` model
  - `Role` model with a many-to-many `roles()` relationship
  - `Hash` facade is available in tinker
- Run all commands from the root directory of your Laravel project.
