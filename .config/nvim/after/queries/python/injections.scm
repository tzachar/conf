; extends

(
   (string) @sql
   (#match? @sql "((select|SELECT).*(from|FROM))|((insert|INSERT).*(into|INTO))|((create|CREATE).*(table|TABLE))")
)

(
 call
  function: (attribute attribute: (identifier) @id (#match? @id "execute|read_sql"))
  arguments: (argument_list
     (string (string_content) @sql)
  )
)
