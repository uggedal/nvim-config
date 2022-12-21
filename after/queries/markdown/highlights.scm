;; extends

(task_list_marker_checked) @text.mark.checked

(task_list_marker_unchecked) @text.mark.unchecked

(list_item
	(task_list_marker_checked)
	(paragraph) @text.mark.checked
)

[
  (atx_heading
    (atx_h1_marker))
  (setext_heading
    (setext_h1_underline))
] @text.title.h1

[
  (atx_heading
    (atx_h2_marker))
  (setext_heading
    (setext_h2_underline))
] @text.title.h2

[
  (atx_heading
    (atx_h3_marker))
] @text.title.h3


[
  (atx_h1_marker)
  (atx_h2_marker)
  (atx_h3_marker)
  (setext_h1_underline)
  (setext_h2_underline)
] @text.title.marker
