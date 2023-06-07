#import "template.typ": *


// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(

  title: "Técnico Lisboa MSc Thesis Typst Template ",
  subtitle: "Optional subtitle",
  author: "[Author name]",
  degree: "[Degree Name]",
  supervisors: (
      "Prof. Lorem Ipsum",
      "Prof. Lorem Ipsum",
  ),
  committee: (
    (
      role: "President",
      name: "Prof. Lorem Ipsum"
    ),
    (
      role: "Chair",
      name: "Prof. Lorem Ipsum"
    ),
  ),
  date: "October 2023",
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  abstract: lorem(59),
)



#include "section_1.typ"
#include "section_2.typ"

#bibliography("bibliography.bib")


#show: appendices

#include "appendix_a.typ"
