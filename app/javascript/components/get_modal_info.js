const modalBusinessName = document.querySelector(".modal-business-name")
const modalFieldName = document.querySelector(".modal-field-name")
const modalselectedHour = document.querySelector(".modal-selected-hour")
const modalBusinessAddress = document.querySelector(".modal-business-addres")
const modalSplitable = document.querySelector(".modal-sliptable")
const modalCapacity = document.querySelector(".modal-capacity")
const modalPrice = document.querySelector(".modal-price")

const ctaButtons = document.querySelectorAll(".card-cta")
const fieldsArray = [modalBusinessName, modalFieldName, modalselectedHour, modalBusinessAddress, modalSplitable, modalCapacity, modalPrice ]

const cleanInnerTexts = () => {
  fieldsArray.forEach((field) => {
    field.innerHTML = "";
  });
}

const addInnerTexts = (data) => {
  const businessName = `<h3> ${data.business.name} </h3>`;
  const fieldName = `<h5> ${data.name} </h5>`;
  const selectedHour = `27/07/2018`;
  const businessAddress = `<p> ${data.business.address} </p>`;
  const splitable = `<p> toggle button </p>`;
  const fieldCapacity = `<p> ${data.capacity} </p>`;
  const fieldPrice = `<p> $ ${data.price_cents.toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} </p>`;

  modalBusinessName.insertAdjacentHTML("beforeend", businessName);
  modalFieldName.insertAdjacentHTML("beforeend", fieldName);
  modalselectedHour.insertAdjacentHTML("beforeend", selectedHour);
  modalBusinessAddress.insertAdjacentHTML("beforeend", businessAddress);
  modalSplitable.insertAdjacentHTML("beforeend", splitable);
  modalCapacity.insertAdjacentHTML("beforeend", `Número de jugadores: ${fieldCapacity}`);
  modalPrice.insertAdjacentHTML("beforeend", fieldPrice);

}

const sendInfoToTheModal = (cardId) => {
      url = ('http://localhost:3000/fields/' + cardId)
      fetch(url)
        .then(response => response.json())
        .then((data) => {
          cleanInnerTexts();
          addInnerTexts(data);
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

