; extends
(
   (comment) @Todo
   (#match? @Todo "TODO:")
)

(
   (string) @sql
   (#match? @sql "((select|SELECT).*(from|FROM))|((insert|INSERT).*(into|INTO))")
)

(
 call
  function: (attribute attribute: (identifier) @id (#match? @id "execute|read_sql"))
  arguments: (argument_list
     (string) @sql
  )
)
