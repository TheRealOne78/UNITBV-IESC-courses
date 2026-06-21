// Schimbă textul unui paragraf când se apasă butonul
document.getElementById("schimbaText").addEventListener("click", function() {
    document.querySelector(".text").innerText = "Textul a fost schimbat!";
});

// Schimbă culoarea titlului principal
document.getElementById("titlu").addEventListener("mouseover", function() {
    this.style.color = "red";
});

// Resetare culoare titlu când mouse-ul pleacă
document.getElementById("titlu").addEventListener("mouseout", function() {
    this.style.color = "white";
});


// Adaugă un element nou în listă
const lista = document.querySelector("ul");
const nouElement = document.createElement("li");
nouElement.innerText = "Element 4";
nouElement.classList.add("element");
lista.appendChild(nouElement);


function tableColorSwitcher() {
    document.getElementById("table-id").style.backgroundColor = "lightgreen";
    document.querySelectorAll("p").forEach.color = "#FFCADC";
}

function hideBtn() {
    //document.querySelectorAll(".hidden"). = "none";
}
