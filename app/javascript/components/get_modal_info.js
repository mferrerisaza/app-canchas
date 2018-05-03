const modalHeader = document.querySelector(".modal-title")
const modalBusinessName = document.querySelector(".modal-business-name")
const modalFieldName = document.querySelector(".modal-field-name")

const ctaButtons = document.querySelectorAll(".card-cta")

const sendInfoToTheModal = (cardId) => {
      url = ('http://localhost:3000/fields/' + cardId)
      fetch(url)
        .then(response => response.json())
        .then((data) => {
          const fieldName = `<h3> ${data.name} </h3>`;
          modalFieldName.insertAdjacentHTML("beforeend", fieldName);
        })
}
const getCardId = (event) => {
      const cardId = event.currentTarget.dataset.id;
      sendInfoToTheModal(cardId);
    };

const callGetIdOnEvent = (btn) => {
  btn.addEventListener("click", getCardId);
};

const selectCtaButtons = () => {
  ctaButtons.forEach(callGetIdOnEvent);
}

document.addEventListener("DOMContentLoaded", () => {
  selectCtaButtons();
})

