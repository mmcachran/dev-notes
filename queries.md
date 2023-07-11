```bash
SELECT 
  wpUser.ID AS "WP User ID",
  wpUser.user_registered AS "Date Registered",
  MAX(
    CASE WHEN userMeta.meta_key = 'old_user_id' THEN userMeta.meta_value ELSE NULL END
  ) AS "GUID", 
  MAX(
    CASE WHEN userMeta.meta_key = 'first_name' THEN userMeta.meta_value ELSE NULL END
  ) AS "First Name", 
  MAX(
    CASE WHEN userMeta.meta_key = 'last_name' THEN userMeta.meta_value ELSE NULL END
  ) AS "Last Name" 
FROM 
  wp_users AS wpUser 
  LEFT JOIN wp_usermeta AS userMeta ON wpUser.ID = userMeta.user_id 
WHERE 
  EXISTS(
    SELECT 
      user_id 
    FROM 
      wp_usermeta AS userGuid 
    WHERE 
      userGuid.meta_key = 'old_user_id' 
      AND wpUser.ID = userGuid.user_id 
      AND userGuid.meta_value NOT IN (
        SELECT 
          UserId 
        FROM 
          old_memberships
      )
  ) 
  AND CAST(wpUser.user_registered AS DATE) <= '2023-06-15 00:00:00'
GROUP BY 
  wpUser.ID
ORDER BY user_registered DESC

```
