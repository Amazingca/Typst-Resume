#let resume(
  // Basic preliminary data for the document. More will be likely added later.
  title: none,
  safeMode: false, // If true, will substitute some characters with other sequences to prevent data-scraping on the web.
  safeModePlus: false, // Will also substitute the dots in urls.
  justify: false, // Justify the text in the document.
  replacements: (
    "@": " [at] ",
    ".": " [dot] "
  ),
  margins: (
    x: 1in,
    y: 1in,
  ),
  // Header data for the document.
  name: none,
  pronouns: "",
  email: "",
  phone: "",
  links: (
    linkedin: "",
    github: "",
    website: ""
  ),
  content
) = {
  if (
    title == none or
    name == none
  ) {
    let names = ()
    if title == none {names.push("title")}
    if name == none {names.push("name")}
    panic("The parameters '" + names.join(", ", last: " and ") + "' are required values!")
  } else [
    #set page("us-letter", margin: (x: margins.x, y: margins.y))

    #set par(justify: justify)
    
    #set text(font: "New Computer Modern", size: 12pt)
    
    #show heading: set text(weight: "regular")
    #show heading.where(level: 1): set text(size: 20pt)
    #show heading.where(level: 2): set text(size: 15pt)

    // Update content that should be modified due to safe mode.
    #if safeModePlus {
      email = email.replace(".", replacements.at("."))
      links.linkedin = links.linkedin.replace(".", replacements.at("."))
      links.github = links.github.replace(".", replacements.at("."))
      links.website = links.website.replace(".", replacements.at("."))
      safeMode = true
    }
    #if safeMode {
      email = email.replace("@", replacements.at("@"))
    } else {
      email = link("mailto:" + email)[#email]
      phone = link("tel:" + phone.replace(regex("[^0-9]"), ""))[#phone]
      if "linkedin" in links {links.linkedin = link(links.linkedin)[#links.linkedin]}
      if "github" in links {links.github = link(links.github)[#links.github]}
      if "website" in links {links.website = link(links.website)[#links.website]}
    }

    #grid(
      columns: (1fr, auto),
      gutter: 1em,
      align: (bottom, bottom + right),
      [= #name #if (pronouns != "") {text(style: "oblique", size: 12pt)[(#pronouns)]}], email,
      grid.cell(align: top)[== #title], phone,
      ..for item in links {
        ([], item.at(1))
      }
    )

    #content
  ]
}

#let section(
  title: none,
  tabular: (),
  content
) = {
  if (
    title == none
  ) {
    let names = ()
    if title == none {names.push("title")}
    panic("The parameters '" + names.join(", ", last: " and ") + "' are required values!")
  } else [
    
    #show heading.where(level: 3): set text(size: 15pt, weight: "semibold")
    
    === #title

    #for items in tabular {
      set par(spacing: 0.5em)
      grid(
        columns: (1fr, auto),
        align: (top, top + right),
        gutter: 0.5em,
        items.at(0), text(weight: "bold")[#items.at(1)],
        text(style: "oblique")[#items.at(2)], text(style: "oblique")[#items.at(3)]
      )

      items.at(4)

      if items != tabular.last() {v(0.75em)} // Vertically spaces between tabular items except the last because of par() spacing rules.
    }

    #content
  ]
}
