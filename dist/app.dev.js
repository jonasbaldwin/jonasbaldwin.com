"use strict";

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
  var queryString = window.location.search;
  var urlParams = new URLSearchParams(queryString);
  var source = urlParams.get("source").toLowerCase();

  if (source == "mb") {
    showNameChange();
  }
}

window.onload = function (event) {
  checkNameChange();
  hideNameChangeListener();
};
//# sourceMappingURL=app.dev.js.map
