let darkState             = false;
let paragraphChangedState = false;

let paragraph          = document.getElementById("changing-paragraph");
let themeToggleButton1 = document.getElementById("theme-toggle");

function toggleParagraphColor() {
  if(paragraphChangedState)
    paragraph.style.color = "#696969";
  else
    paragraph.style.color = "#EC8286";

  paragraphChangedState = !paragraphChangedState;
}

function toggleTheme() {
  if(darkState) {
    themeToggleButton1.innerHTML = "⋆⁺☾₊";

    document.documentElement.style.setProperty("color-scheme", "light", "important");
    document.querySelectorAll(".page-dark").forEach(e => e.classList.remove("page-dark"));
    document.querySelectorAll(".profile-section-dark").forEach(e => e.classList.remove("profile-section-dark"));
    document.querySelectorAll(".table-dark").forEach(e => e.classList.remove("table-dark"));
    document.querySelectorAll(".textbox-dark").forEach(e => e.classList.remove("textbox-dark"));
    document.querySelectorAll(".textarea-dark").forEach(e => e.classList.remove("textarea-dark"));
    document.querySelectorAll(".nav-dark").forEach(e => e.classList.remove("nav-dark"));
    document.querySelectorAll(".header-dark").forEach(e => e.classList.remove("header-dark"));
  } else {
    themeToggleButton1.innerHTML = "☀";

    document.documentElement.style.setProperty("color-scheme", "dark", "important");
    document.querySelectorAll(".page").forEach(e => e.classList.add("page-dark"));
    document.querySelector("#profile-section").classList.add("profile-section-dark");
    document.querySelectorAll("table").forEach(e => e.classList.add("table-dark"));
    document.querySelectorAll(".textbox").forEach(e => e.classList.add("textbox-dark"));
    document.querySelectorAll(".textarea").forEach(e => e.classList.add("textarea-dark"));
    document.querySelector("nav").classList.add("nav-dark");
    document.querySelector("header").classList.add("header-dark");

  }

  darkState = !darkState;
}

function resetChanges() {
  if(paragraphChangedState)
    toggleParagraphColor();

  if(darkState)
    toggleTheme();
}
