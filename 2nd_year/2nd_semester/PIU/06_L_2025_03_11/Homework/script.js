function send() {
  let prefPlanet       = document.getElementById("prefplanet").value;
  let levelOfInterest  = document.getElementById("loi").value;
  let selectedMissions = [];
  let feedback         = document.getElementById("description").value;

  document.querySelectorAll("input[name='missions']:checked").forEach((checkbox) => {
    selectedMissions.push(checkbox.value);
  });

  let formData = {
    prefPlanet,
    levelOfInterest,
    selectedMissions,
    feedback
  };

  localStorage.setItem("formData", JSON.stringify(formData));

  document.getElementById("status").innerText = "Formular trimis!";
}

function loadFormData() {
  let savedData = localStorage.getItem("formData");

  if (savedData) {
    let formData = JSON.parse(savedData);

    document.getElementById("prefplanet").value  = formData.prefPlanet;
    document.getElementById("loi").value         = formData.levelOfInterest;
    document.getElementById("description").value = formData.feedback;

    document.querySelectorAll("input[name='missions']").forEach((checkbox) => {
      checkbox.checked = formData.selectedMissions.includes(checkbox.value);
    });
  }
}


async function updateISS() {
  try {
    let response = await fetch('https://api.wheretheiss.at/v1/satellites/25544');
    let data     = await response.json();
    let lat      = data.latitude.toFixed(2);
    let lon      = data.longitude.toFixed(2);

    document.getElementById("iss-coords").textContent = `${lat}° N, ${lon}° E`;
  } catch (error) {
    console.error("Error fetching ISS location:", error);
  }
}

async function updatePeopleInSpace() {
  try {
    let response = await fetch('http://api.open-notify.org/astros.json');
    let data     = await response.json();
    let number   = data.number;
    let names    = data.people.map(person => person.name).join(", ");

    document.getElementById("ppl-in-space").textContent = number;
    console.log(`People in space: ${names}`); // Optional: Log names
  } catch (error) {
    console.error("Error fetching number of people in space:", error);
  }
}

setInterval(() => {
  updateISS();
  updatePeopleInSpace();
}, 10000);

updateISS();
//updatePeopleInSpace();

window.onload = loadFormData;
