-- What tasks are open (not pending/closed) and assigned to me?
-- Show the most idle tasks first.

SELECT CONCAT('https://alloc.cyber.com.au/task/task.php?taskID=', task.taskID) AS URL,
       max(comment.commentCreatedTime) AS activity,
       task.taskName
  FROM task
  JOIN person ON (task.personid = person.personid)
  LEFT OUTER JOIN comment ON (task.taskID = comment.commentMasterID AND comment.commentMaster = 'task')
  WHERE username in ('twb', 'sysadmin', 'prisonpc')
    AND taskStatus LIKE 'open_%'
  GROUP BY task.taskID
  ORDER BY activity ASC
  LIMIT 1000;
