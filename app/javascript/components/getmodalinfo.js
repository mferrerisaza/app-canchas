const modalBusinessName = document.querySelector(".modal-business-name")
const modalFieldName = document.querySelector(".modal-field-name")
const modalselectedHour = document.querySelector(".modal-selected-hour")
const modalBusinessAddress = document.querySelector(".modal-business-address")
const modalSplitable = document.querySelector(".modal-sliptable")
const modalCapacity = document.querySelector(".modal-capacity")
const modalPrice = document.querySelector(".modal-price")
const modalSplitableDiv = document.querySelector(".modal-splitable");

const ctaButtons = document.querySelectorAll(".card-cta");

const fieldsArray = [modalBusinessName, modalFieldName, modalselectedHour, modalBusinessAddress, modalSplitableDiv, modalCapacity, modalPrice ];

const makeChangesIfToggleChanges = (cardId) => {
    const modalToggleStatus = document.querySelector(".modal-splitable").querySelector(".splitable");
    modalToggleStatus.addEventListener("change", (event) => {
      const modalStatus = event.target.checked;
      const url = ('/fields/' + cardId)
        fetch(url)
          .then(response => response.json())
          .then((data) => {
            if (modalStatus) {
              document.querySelector(`#toggle${cardId}`).querySelector(".splitable").checked = true;
              modalPrice.querySelector("p").innerHTML = "";
              modalPrice.querySelector("p").innerHTML = `$ ${(data.price_cents/100/data.capacity).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} por jugador`;
            } else {
              document.querySelector(`#toggle${cardId}`).querySelector(".splitable").checked = false;
              modalPrice.querySelector("p").innerHTML = "";
              modalPrice.querySelector("p").innerHTML = `$ ${(data.price_cents/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')}`;
            }
          }
        );
      })
  }

const renderToggle = (status, cardId) => {
  const value = status ? "checked" : "";
  return `<div class="card-toggle">
            <div>
              <label class="switch">
                <input class="splitable" type="checkbox" ${value}>
                <span class="slider round"></span>
              </label>
            </div>
          </div>`;
};

const getToggle = (cardId) => {
  return document.getElementById(`toggle${cardId}`).querySelector(".splitable").checked === true;
};

const cleanInnerTexts = () => {
  fieldsArray.forEach((field) => {
    field.innerHTML = "";
  });
};

const addInnerTexts = (data, cardId) => {

  modalBusinessName.insertAdjacentHTML("beforeend", `<h3 dataset=${cardId}> ${data.business.name} </h3>`);
  modalFieldName.insertAdjacentHTML("beforeend", `<h5> ${data.name} </h5>`);
  modalselectedHour.insertAdjacentHTML("beforeend", `27/07/2018`);
  modalBusinessAddress.insertAdjacentHTML("beforeend", `<p> ${data.business.address} </p>`);
  modalSplitableDiv.insertAdjacentHTML("beforeend", renderToggle(getToggle(cardId),cardId), cardId);
  modalCapacity.insertAdjacentHTML("beforeend", `<p> Número de jugadores: ${data.capacity} </p>`);
  if (getToggle(cardId)) {
    modalPrice.insertAdjacentHTML("beforeend", `<p> $ ${(data.price_cents/100/data.capacity).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} por jugador</p>`);
  } else {
    modalPrice.insertAdjacentHTML("beforeend", `<p> $ ${(data.price_cents/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} </p>`);
  }
};

const sendInfoToTheModal = (cardId) => {
  const url = ('/fields/' + cardId)
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      cleanInnerTexts();
      addInnerTexts(data, cardId);
      makeChangesIfToggleChanges(cardId)
    });
};
const getCardId = (event) => {
      const cardId = event.currentTarget.dataset.id;
      sendInfoToTheModal(cardId);
    };

const addListenerOnClick = (btn) => {
  btn.addEventListener("click", getCardId);
};

const selectCtaButtons = () => {
  ctaButtons.forEach(addListenerOnClick);
};

document.addEventListener("DOMContentLoaded", () => {
  selectCtaButtons();
});
