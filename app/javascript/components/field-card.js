const resetOtherCards = (cardSection) => {
    cardSection.classList.add("card-collapsed");
    cardSection.parentNode.querySelector(".schedule-dropdown").querySelector("p").innerHTML= "VER HORARIOS";
    cardSection.parentNode.querySelector(".schedule-dropdown").querySelector("i").classList.remove("rotate-caret");
    cardSection.querySelectorAll(".schedule-btn.btn.btn-xs.active").forEach((scheduleBtn) => {
      scheduleBtn.classList.remove("active");
    })
  }

const toggleClass = (event) => {
  const targetDropdown = event.currentTarget.parentNode.querySelector(".card-available-hours");
  const dropdownState =  targetDropdown.classList.contains("card-collapsed");
  document.querySelectorAll(".card-available-hours:not(.card-collapsed").forEach(resetOtherCards);
  if (dropdownState){
    targetDropdown.classList.remove("card-collapsed");
    event.currentTarget.querySelector("p").innerHTML="";
    event.currentTarget.querySelector("i").classList.toggle("rotate-caret");
  }
}

const addClickListener = (element) => {
  element.style.cursor = "pointer";
  element.addEventListener("click", toggleClass);
}

const retriveDropdowns = () => {
  document.querySelectorAll(".schedule-dropdown").forEach(addClickListener);
}

document.addEventListener("DOMContentLoaded", () => {
  retriveDropdowns();
})

export default retriveDropdowns
