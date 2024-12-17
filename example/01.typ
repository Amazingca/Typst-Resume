#import "resume.typ" as resume: *

#show: resume.with(
  title: "Title of Document",
  name: "A Person",
  pronouns: "with pronouns",
  email: "someone@example.com",
  phone: "+0 (123) 456-7890",
  links: (
    linkedin: "https://linkedin.com/in/",
    github: "https://github.com/"
  ),
  margins: (
    x: 0.75in,
    y: 1in
  ),
  safeMode: false,
  justify: true
)

#section(
  title: "Qualifications"
)[
  Here is the qualifications section of the document. We can use other Typst styling in here. Text is not justified by default, though can be enabled if preferred.

  Some bullet points:
  - One
  - Two
  - Three

  Numbered list:
  + One
  + Two
  4. Four
  + Five
]

#section(
  title: "Work History",
  tabular: (
    (
      [Title of Position A], [Date -- Date],
      [Location of Position A], [Additional Context],
      [
        - Here are some things that make me stand out in this position.
      ]
    ),
    (
      [Title of Position B], [Date -- Date],
      [Location of Position B], [Additional Context],
      [
        - Here are some things that make me stand out in this position.
      ]
    ),
    (
      [Title of Position C], [Date -- Date],
      [Location of Position C], [Additional Context],
      [
        - Here are some things that make me stand out in this position.
      ]
    )
  )
)[
  It is also possible to include body content in addition, which is placed after the tabular content. Otherwise, leave the text section empty.
]

If you prefer to use your own styling, you can use Typst as you ordinarily would here.