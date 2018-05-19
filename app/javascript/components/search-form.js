const addListenerToSelect = (event) => {
  const valor = event.currentTarget.value
  if (valor === "") {
    document.getElementById("search-capacity-dropdown").innerHTML = "# Jugadores"
  } else {
    document.getElementById("search-capacity-dropdown").innerHTML = `${valor / 2} Vs. ${valor / 2}`
  }
}


document.addEventListener("DOMContentLoaded", () => {
  const capacitySelect = document.getElementById("capacity_limit");
  if(capacitySelect){
    capacitySelect.addEventListener("click", addListenerToSelect);
  }
})
