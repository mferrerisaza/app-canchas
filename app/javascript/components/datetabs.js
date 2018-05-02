

const removeTabUnderline = (element) => {
  element.classList.remove("active-date");
}

const addTabUnderline = (event) => {
  const tabs = Array.from(event.currentTarget.parentNode.children);
  tabs.forEach(removeTabUnderline);
  event.currentTarget.classList.add("active-date");
};

const addTabListeners = (element) => {
  element.style.cursor = "pointer";
  element.addEventListener("click",
    addTabUnderline
  );
};

function selectDateTabs() {
  document.querySelectorAll(".date-tab").forEach(addTabListeners);
}


document.addEventListener("DOMContentLoaded", () => {
  selectDateTabs();
})


