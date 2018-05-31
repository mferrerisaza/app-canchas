import sendInfoToTheModal from './getmodalinfo.js'

const resetOtherCards = (cardSection) => {
    cardSection.classList.add("card-collapsed");
    cardSection.parentNode.querySelector(".schedule-dropdown").querySelector("p").innerHTML= "VER HORARIOS";
    cardSection.parentNode.querySelector(".schedule-dropdown").querySelector("i").classList.remove("rotate-caret");
    const scheduleBtns = cardSection.querySelectorAll(".schedule-btn.btn.btn-xs.active")

    for(var i = 0; i < scheduleBtns.length; i++) {
      scheduleBtns[i].classList.remove("active");
    }
  }

const toggleClass = (event) => {
  const targetDropdown = event.currentTarget.parentNode.querySelector(".card-available-hours");
  const dropdownState =  targetDropdown.classList.contains("card-collapsed");
  const cardsExpanded = document.querySelectorAll(".card-available-hours:not(.card-collapsed)")
  for(var i = 0; i < cardsExpanded.length; i++) {
    resetOtherCards(cardsExpanded[i]);
  }

  if (dropdownState){
    targetDropdown.classList.remove("card-collapsed");
    event.currentTarget.querySelector("p").innerHTML="";
    event.currentTarget.querySelector("i").classList.toggle("rotate-caret");
  }

  const bookingBtn = event.currentTarget.parentNode.parentNode.parentNode.querySelector(".card-cta.btn.btn-cta");
  bookingBtn.disabled = true;
  bookingBtn.innerHTML =  "NO HAS SELECCIONADO NINGÚN HORARIO";
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
  for( var i = 0; i < dropdowns.length; i++) {
    addDropdownClickListener(dropdowns[i]);
  }
}

const retriveTimeBtns = () => {
  const btns = document.querySelectorAll(".schedule-btn.btn.btn-xs");
  for( var i = 0; i < btns.length; i++) {
   addTimeBtnClickListener(btns[i]);
  }
}

document.addEventListener("DOMContentLoaded", () => {
  retriveDropdowns();
  retriveTimeBtns();
})

export { retriveTimeBtns, retriveDropdowns };
