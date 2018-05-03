const modalHeader = document.querySelector(".modal-title").innerHTML
const modalBusinessName = document.querySelector(".modal-business-name").innerHTML
const modalBusinessName = document.querySelector(".modal-business-name").innerHTML

const ctaButtons = document.querySelectorAll(".card-cta")

const getCardId = (event) => {
      const cardId = event.currentTarget.dataset.id;
    };

const callGetIdOnEvent = (btn) => {
  btn.addEventListener("click", getCardId);
};

ctaButtons.forEach(callGetIdOnEvent);


