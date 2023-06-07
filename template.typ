
#let heading_style(it) = {
  // Set chapter
  locate(loc => {
    let heading_number = counter(heading).at(loc).at(0)
    if it.level == 1{
      if heading_number != 0 {
        pagebreak()
        align(right,
          grid(rows: (140pt,auto),
            text(140pt, fill: rgb("#999999"), counter(heading).display()),
            text(28pt, it.body)
          )
        )
        pagebreak()
      } else {
        pad(
          bottom: 50pt,
        text(30pt, it))
      }
      // Increase figures counter
      // counter(figure).step(level: 1)
    }
    else if it.level <= 3 {
      pad(
        top: 10pt,
        bottom: 10pt,
        text(14pt, it)
      )
    }
    else if it.level > 3 {
      // Set run-in subheadings, starting at level 4.
      parbreak()
      text(11pt, style: "italic", weight: "regular", it.body + ".")
    } else {
      it
    }
  })
}

#let project(
  school_logo: none,
  cover_image: none,
  title: "",
  subtitle: "",
  author: "",
  degree: "",
  supervisors: (),
  committee: (),
  date: "",
  abstract: [],
  abstract_pt: none,
  custom_sections: (),
  body,
) = {
  // Set the document's basic properties.
  set document(author: author, title: title)
  set page(
    margin: (left: 20mm, right: 20mm, top: 20mm, bottom: 20mm),
  )
  set text(font: "Source Sans Pro", lang: "en")
  set heading(numbering: "1.1")
  //set figure(numbering: "1.1")
  //show figure.where(kind: table): it => {
  //  counter(figure.where(kind: table)).step(level: 1)
  //  it
  //}

  show heading: heading_style

  // Table of content and lists style
  show outline: it => {
    show heading: set text(fill: rgb("#000"))
    set text(fill: rgb("#666666"), weight: 500)
    it
  }

  // Set a heading style for bibliography
  show bibliography: it => {
    show heading: it_heading => {
      pagebreak()
      pad(
        bottom: 50pt,
        text(30pt, it_heading.body)
      )
    }
    it
  }

  // Cover page
  
  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  if school_logo == none {
    school_logo = "images/ist-logo.png"
  }
  
  image(school_logo, height: 20mm, width: auto)
  v(8mm)

  // Image
  if cover_image != none and cover_image.trim().len() > 0 {
    pad(bottom: 10mm,
        image(cover_image)
    )
  } else {
    v(58mm)
  }
  
  align(center, {
    block(
      width: 80%,
      {
      // Title
      text(16pt, weight: "bold", [This is the Title of the Thesis and it is a very Big Title covering More than One Line])
  
      // Subtitle
      if subtitle.trim().len() > 0 {
        pad(
          top: 0.8em,
          text(14pt, subtitle)
        )
      }
  
      // Author information.
      pad(
        top: 3.2em,
        text(16pt, weight: "bold", author)
      )
  
      // Thesis information.
      pad(
        top: 3.2em, {
        text(12pt, [Thesis to obtain the Master of Science Degree in])
        linebreak()
        v(1.8em)
        text(16pt, weight: "bold", degree)
      })
  
      // Supervisor information
      if supervisors.len() > 0 {
        pad(
          top: 1.8em,
          text(12pt, {
            if supervisors.len() > 1 {
              [Supervisors: ]
            } else {
              [Supervisor: ]
            }
            supervisors.join([ \ ])
          })
        )
      }
    
      // Committee information.
      if committee.len() > 0 {
        pad(top: 1.2em, text(14pt, weight: "bold", [Examination Committee]))
        pad(
          top: 1.2em,
          grid(
            rows: (auto,) * calc.min(3, committee.len()),
            gutter: 0.5em,
            ..committee.map(member => text(12pt, member.role + [: ] + member.name)),
          ),
        )
      }
  
      
    })
  })
  // Date
  align(center + bottom,
    pad(
      top: 4em,
      text(14pt, weight: "bold", date)
    )
  )
  pagebreak()
  // End of cover page

  counter(page).update(0)
  set page(
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 30mm),
    footer: [
      #set align(center)
      #set text(12pt, weight: "bold")
      #counter(page).display(
        "i",
      )
    ],
    number-align: center,
  )

  // Custom sections (Ackowledgments, Declarations, etc.)
  

  // Abstract page.
  v(1fr)
  heading(outlined: false, numbering: none, text(0.85em)[Abstract])
  align(left)[
    #set par(justify: true)
    #abstract
  ]
  v(1.618fr)
  pagebreak()

  if abstract_pt != none {
    v(1fr)
    heading(outlined: false, numbering: none, text(0.85em)[Resumo])
    align(left)[
      #set par(justify: true)
      #abstract_pt
    ]
    v(1.618fr)
    pagebreak()
  }

  // Table of contents.
  outline(depth: 4, indent: true)
  pagebreak()

  // Figure listing
  outline(
    title: [List of Figures],
    target: figure.where(kind: image),
  )

  pagebreak()
  // Table listing
  outline(
    title: [List of Tables],
    target: figure.where(kind: table),
  )

  // Reset page counter and make a empty page with no number
  set page(
    footer: []
  )
  pagebreak()
  counter(page).update(0)

  // Main content
  set page(
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 30mm),
    footer: [
      #set align(center)
      #set text(12pt, weight: "bold")
      #counter(page).display(
        "1",
      )
    ],
    number-align: center,
  )
  
  // Main body.
  set par(justify: true)

  body
}

#let appendices(body) = {
    counter(heading).update(0)
    counter("appendices").update(1)
    
    set heading(
      numbering: (..nums) => {
        let vals = nums.pos()
        let value = "ABCDEFGHIJ".at(vals.at(0) - 1)
        if vals.len() == 1 {
          return value 
        }
        else {
          return value + "." + nums.pos().slice(1).map(str).join(".")
        }
      }
    );
    [#pagebreak() #body]
}



