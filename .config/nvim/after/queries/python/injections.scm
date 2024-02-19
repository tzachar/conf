; extends

(string
  (string_content) @injection.content
    (#match? @injection.content "((select|SELECT).*(from|FROM))|((insert|INSERT).*(into|INTO))|((create|CREATE).*(table|TABLE))")
    (#set! injection.language "sql"))

(call
  function: (attribute attribute: (identifier) @id (#match? @id "execute|read_sql"))
  arguments: (argument_list
    (string (string_content) @injection.content (#set! injection.language "sql"))))
