; extends

(
   (string) @sql
   (#match? @sql "(select|SELECT).*(from|FROM)")
)

(
 call
  function: (attribute attribute: (identifier) @id (#match? @id "execute|read_sql"))
  arguments: (argument_list
     (string) @sql
  )
)
