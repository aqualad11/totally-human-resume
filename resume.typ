#import "@preview/toy-cv:0.1.0": *

// Load configuration and data
#let config = yaml("config.yaml")
#let personal = yaml("data/personal.yaml")
#let experience-data = yaml("data/experience.yaml")
#let education-data = yaml("data/education.yaml")
#let skills-data = yaml("data/skills.yaml")
#let projects-data = yaml("data/projects.yaml")

// Theme color from config
#let main-color = rgb(config.theme.color)

// Helper: filter entries by IDs from config
#let filter-entries(entries, section-name) = {
  let include-list = config.include.at(section-name, default: "all")
  if include-list == "all" {
    entries
  } else {
    entries.filter(e => include-list.contains(e.id))
  }
}

// Helper: limit highlights if configured
#let limit-highlights(highlights) = {
  if config.max_highlights == none {
    highlights
  } else {
    highlights.slice(0, calc.min(highlights.len(), config.max_highlights))
  }
}

// Build left sidebar content
#let left-content = [
  #contact-section(main-color: main-color, i18n: "en", contact-entries: (
    (
      logo-name: "envelope",
      logo-link: "mailto:" + personal.contact.email,
      logo-text: personal.contact.email,
    ),
    (
      logo-name: "phone",
      logo-link: "tel:" + personal.contact.phone.replace(" ", "").replace("(", "").replace(")", "").replace("-", ""),
      logo-text: personal.contact.phone,
    ),
    (
      logo-name: "github",
      logo-link: "https://github.com/" + personal.contact.github,
      logo-text: personal.contact.github,
      logo-font: "Font Awesome 6 Brands",
    ),
    (
      logo-name: "globe",
      logo-link: "https://" + personal.contact.website,
      logo-text: personal.contact.website,
    ),
    (
      logo-name: "location-dot",
      logo-text: personal.contact.location,
    ),
  ))

  #v(1fr)

  #left-section(title: "Skills & Tools", [
    #for category in skills-data.categories [
      *#category.name:*
      #category.skills.join(", ")

    ]
  ])
]

// Main document
#show: cv.with(
  title: personal.name,
  subtitle: [
    #personal.title \
    #text(size: 0.9em)[#personal.tagline]
  ],
  avatar: none,
  left-content: left-content,
)

// Render sections in configured order
#for section in config.sections [
  #if section == "experience" [
    #right-column-subtitle("Professional Experience")
    #let entries = filter-entries(experience-data, "experience")
    #for (i, job) in entries.enumerate() [
      #cv-entry(
        title: [*#job.title*, #job.company],
        date: job.start_date + " – " + job.end_date,
        subtitle: [#job.location],
        [
          #for highlight in limit-highlights(job.highlights) [
            - #highlight
          ]
        ],
      )
      #if i < entries.len() - 1 [#v(1fr)]
    ]
    #v(1fr)
  ]

  #if section == "projects" [
    #right-column-subtitle("Projects")
    #let entries = filter-entries(projects-data, "projects")
    #for (i, project) in entries.enumerate() [
      #cv-entry(
        title: [*#project.name*],
        date: project.start_date + " – " + project.end_date,
        subtitle: [#project.role, #project.location],
        [
          #for highlight in limit-highlights(project.highlights) [
            - #highlight
          ]
        ],
      )
      #if i < entries.len() - 1 [#v(1fr)]
    ]
    #v(1fr)
  ]

  #if section == "education" [
    #right-column-subtitle("Education")
    #let entries = filter-entries(education-data, "education")
    #for (i, edu) in entries.enumerate() [
      #cv-entry(
        title: [*#edu.degree*],
        date: edu.start_date + " – " + edu.end_date,
        subtitle: [#edu.institution, #edu.location],
        [
          #for highlight in edu.highlights [
            - #highlight
          ]
        ],
      )
      #if i < entries.len() - 1 [#v(1fr)]
    ]
  ]

  #if section == "skills" [
    // Skills are in the sidebar, but we could add a right-column version here if needed
  ]
]

