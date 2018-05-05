const formatHour = (hour)=> {
  if (hour === 12) {
    return `${hour}:00 PM`
  } else if (hour > 12) {
    return `${hour - 12}:00 PM`
  } else {
    return `${hour}:00 AM`
  }
 }

const makeChangesIfToggleChanges = (cardId, modalPrice, price, capacity) => {
  const modalToggleStatus = document.querySelector(".modal-splitable").querySelector(".splitable");
  modalToggleStatus.addEventListener("change", (event) => {
    const modalStatus = event.currentTarget.checked;
    if (modalStatus) {
      // document.querySelector(`#toggle${cardId}`).querySelector(".splitable").checked = true;
      modalPrice.querySelector("p").innerHTML = "";
      modalPrice.querySelector("p").innerHTML = `$ ${(price/100/capacity).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} por jugador`;
    } else {
      // document.querySelector(`#toggle${cardId}`).querySelector(".splitable").checked = false;
      modalPrice.querySelector("p").innerHTML = "";
      modalPrice.querySelector("p").innerHTML = `$ ${(price/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')}`;
    }
    })
  }

const renderToggle = () => {
  return `<div class="card-toggle">
            <div>
              <label class="switch">
                <input class="splitable" type="checkbox">
                <span class="slider round"></span>
              </label>
            </div>
          </div>`;
};

// const getToggle = (cardId) => {
//   return document.getElementById(`toggle${cardId}`).querySelector(".splitable").checked === true;
// };

const cleanInnerTexts = (fieldsArray) => {
  fieldsArray.forEach((field) => {
    field.innerHTML = "";
  });
};

const addInnerTexts = (data, cardId, modalBusinessName, modalFieldName, modalselectedHour, modalBusinessAddress, modalCapacity, modalPrice, modalSplitableDiv) => {
  const bookingDate = document.querySelector(".schedule-btn.btn.btn-xs.active").children[0].value;
  const bookingTime = document.querySelector(".schedule-btn.btn.btn-xs.active").children[0].dataset.time
  modalBusinessName.insertAdjacentHTML("beforeend", `<h3 dataset=${cardId}> ${data.business.name} </h3>`);
  modalFieldName.insertAdjacentHTML("beforeend", `<h5> ${data.name} </h5>`);
  modalselectedHour.insertAdjacentHTML("beforeend", `Reservar esta cancha el ${bookingDate} entre ${formatHour(parseInt(bookingTime, 10))} y ${formatHour(parseInt(bookingTime, 10) + 1)}`);
  modalBusinessAddress.insertAdjacentHTML("beforeend", `<p> ${data.business.address} </p>`);
  modalSplitableDiv.insertAdjacentHTML("beforeend", renderToggle());
  modalCapacity.insertAdjacentHTML("beforeend", `<p> Número de jugadores: ${data.capacity} </p>`);
  modalPrice.insertAdjacentHTML("beforeend", `<p> $ ${(data.price_cents/100).toFixed().replace(/(\d)(?=(\d{3})+(,|$))/g, '$1.')} </p>`);
};

const sendInfoToTheModal = (cardId) => {
  const modalBusinessName = document.querySelector(".modal-business-name")
  const modalFieldName = document.querySelector(".modal-field-name")
  const modalselectedHour = document.querySelector(".modal-selected-hour")
  const modalBusinessAddress = document.querySelector(".modal-business-address")
  const modalCapacity = document.querySelector(".modal-capacity")
  const modalPrice = document.querySelector(".modal-price")
  const modalSplitableDiv = document.querySelector(".modal-splitable");
  const fieldsArray = [modalBusinessName, modalFieldName, modalselectedHour, modalBusinessAddress, modalSplitableDiv, modalCapacity, modalPrice];

  const url = ('/fields/' + cardId)
  fetch(url)
    .then(response => response.json())
    .then((data) => {
      cleanInnerTexts(fieldsArray);
      addInnerTexts(data, cardId, modalBusinessName, modalFieldName, modalselectedHour, modalBusinessAddress, modalCapacity, modalPrice, modalSplitableDiv);
      makeChangesIfToggleChanges(cardId, modalPrice, data.price_cents, data.capacity)
    });
};
const getCardId = (event) => {
    const cardId = event.currentTarget.dataset.id;
    sendInfoToTheModal(cardId);
  };

const addListenerOnClick = (btn) => {
  btn.addEventListener("click", getCardId);
};

export default function selectCtaButtons() {
  const ctaButtons = document.querySelectorAll(".card-cta");
  ctaButtons.forEach(addListenerOnClick);
};

document.addEventListener("DOMContentLoaded", () => {
  selectCtaButtons();
});

