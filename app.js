function showNameChange() {
  var el = document.getElementById("name-change");
  el.classList.add("show");
  el.classList.remove("hide");
}

function hideNameChange(e) {
  console.log("clicked close");
  var el = document.getElementById("name-change");
  el.classList.remove("show");
  el.classList.add("hide");
}

function hideNameChangeListener() {
  var el = document.getElementById("close-name-change");
  el.onclick = hideNameChange;
}

function checkNameChange() {
  const queryString = window.location.search;
  const urlParams = new URLSearchParams(queryString);
  const source = urlParams.get("source").toLowerCase();
  if (source == "mb") {
    showNameChange();
  }
}

window.onload = (event) => {
  checkNameChange();
  hideNameChangeListener();
};
