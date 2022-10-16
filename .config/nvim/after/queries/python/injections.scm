; extends
(
   (string) @sql
   (#match? @sql "(select|SELECT).*(from|FROM)")
)
