import sendInfoToTheModal from './getmodalinfo.js'

const resetOtherCards = (cardSection) => {
    cardSection.classList.add("card-collapsed");
    cardSection.parentNode.querySelector(".schedule-dropdown").querySelector("p").innerHTML= "VER HORARIOS";
    cardSection.parentNode.querySelector(".schedule-dropdown").querySelector("i").classList.remove("rotate-caret");
    const scheduleBtns = cardSection.querySelectorAll(".schedule-btn.btn.btn-xs.active")

    for (let scheduleBtn of scheduleBtns) {
      scheduleBtn.classList.remove("active");
    }
  }

const toggleClass = (event) => {
  const targetDropdown = event.currentTarget.parentNode.querySelector(".card-available-hours");
  const dropdownState =  targetDropdown.classList.contains("card-collapsed");
  const cardsExpanded = document.querySelectorAll(".card-available-hours:not(.card-collapsed")

  for(let card of cardsExpanded) {
    resetOtherCards(card);
  }

  if (dropdownState){
    targetDropdown.classList.remove("card-collapsed");
    event.currentTarget.querySelector("p").innerHTML="";
    event.currentTarget.querySelector("i").classList.toggle("rotate-caret");
  }

  const bookingBtn = event.currentTarget.parentNode.parentNode.parentNode.querySelector(".card-cta.btn.btn-cta");
  bookingBtn.disabled = true;
  bookingBtn.innerHTML =  "NO HA SELECCIONADO NINGÚN HORARIO";
}

const addDropdownClickListener = (element) => {
  element.style.cursor = "pointer";
  element.addEventListener("click", toggleClass);
}

const addTimeBtnClickListener = (element) => {
  element.style.cursor = "pointer";
  element.addEventListener("click", (event) => {
    const bookingBtn = event.currentTarget.parentNode.parentNode.parentNode.querySelector(".card-cta.btn.btn-cta");
    const cardId = bookingBtn.dataset.id;
    sendInfoToTheModal(cardId);
    bookingBtn.innerHTML =  "RESERVAR";
    bookingBtn.disabled = false;
  });
}

const retriveDropdowns = () => {
  const dropdowns = document.querySelectorAll(".schedule-dropdown");
  for(let dropdown of dropdowns) {
    addDropdownClickListener(dropdown);
  }
}

const retriveTimeBtns = () => {
  const btns = document.querySelectorAll(".schedule-btn.btn.btn-xs");
  for(let btn of btns){
   addTimeBtnClickListener(btn);
  }
}

document.addEventListener("DOMContentLoaded", () => {
  retriveDropdowns();
  retriveTimeBtns();
})

export { retriveTimeBtns, retriveDropdowns };
