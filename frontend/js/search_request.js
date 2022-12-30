// start include js datepicker from bootstrap-datepicker
$(document).ready(function () {
  $(".input-group.date .date-search").datetimepicker({
    language: location.href.includes("/rental") ? "en" : "de",
    dateFormat: "d-m-yy",
    timeFormat: "HH:mm:ss",
    minDate: new Date(),
    pickSeconds: true,
    pick12HourFormat: false,
  });
});
// end include js datepicker from bootstrap-datepicker

// ==========================================================

// start define pop-up
let popUpContainer = document.getElementById("pop-up-container");
let closePopUpScreenButton = document.getElementById("close-pop-up-screen");
let pOnPopUp = document.getElementById("error-message-v2");
let popUpContentParent = document.querySelector(".pop-up-content-parent");
let popUpContent = document.getElementById("pop-up-content");
let popUpContentChild = document.getElementById("pop-up-content-child");
let closeRentalPopup = document.getElementById("close-rental-car-popup");
// end define pop-up

// start define search components
let sendingSearchParameters = document.getElementById("send-se-par");
let searchParameters = document.querySelectorAll(".send-se-par");
// end define search components

// start work in result components
let containerForSearch = document.getElementById(
  "container-for-search-results"
);
let resultsContainer = document.getElementById(
  "parent-for-container-search-results"
);
let noResultsMessage = document.getElementById("no-results-found-for-rental");
let errorFoundMessage = document.getElementById("error-found-for-rental");
// end work in result components

// start work in url
let searchUrlForFetch = `/search-available-objects`;
// end work in url

// end define some variables
let allObjectsData = [];
// =============================================

// start main function
let checkFlag = 0;
let searchDataArr = [];
let searchDataObj = {};
let searchDataObjLocal = {};

sendingSearchParameters?.addEventListener("click", (event) => {
  event.preventDefault();
  searchParameters.forEach(async (e, i) => {
    let objectKey = e.parentElement.parentElement
      .querySelector("label")
      .getAttribute("for");

    if (e.value != "") {
      if (objectKey.includes("location")) {
        checkFlag = checkFlag + 1;
        searchDataObj[objectKey] = e.value;
        searchDataObjLocal[objectKey] = e.value;
      } else {
        checkFlag = checkFlag + 1;
        searchDataObj[objectKey] = e.value;
        searchDataObjLocal[objectKey] = e.value;
      }

      //   sending request
      if (checkFlag === 4) {
        console.log(searchDataObj);

        let dropOff = searchDataObj["drop-off-date"]?.split(" ");
        let pickUp = searchDataObj["pick-up-date"]?.split(" ");

        console.log(dropOff, pickUp);

        if (
          new Date(
            `${pickUp[0].split("-")[1]}-${pickUp[0].split("-")[0]}-${
              pickUp[0].split("-")[2]
            } ${pickUp[1]}`
          ) <=
          new Date(
            `${dropOff[0].split("-")[1]}-${dropOff[0].split("-")[0]}-${
              dropOff[0].split("-")[2]
            } ${dropOff[1]}`
          )
        ) {
          searchDataArr.push(searchDataObj);

          popUpContainer.classList.remove("active");

          let sendPickUpDate = `${pickUp[0].split("-")[2]}-${pickUp[0].split("-")[1]}-${pickUp[0].split("-")[0]} ${pickUp[1]}`;
          let sendDropOff = `${dropOff[0].split("-")[2]}-${dropOff[0].split("-")[1]}-${dropOff[0].split("-")[0]} ${dropOff[1]}`;

          const data = new FormData();
          data.set("io", "request");
          data.set("jtl_token", fetchToken);
          data.set("locationId", searchDataObj["pick-up-location"]);
          data.set("categoryId", searchDataObj["category"]);
          data.set("pickUpDate", sendPickUpDate);
          data.set("dropOfDate", sendDropOff);

          try {
            const response = await fiberForPayment.post(
              `${searchUrlForFetch}`,
              data
            );

            response.data.forEach((obj) => {
              allObjectsData.push(obj);
            });

            if (response.status === 200) {
              // main work
              insideFetch(response);
              carPick(response);
              searchDataArr = [];
              searchDataObj = {};
            }
          } catch (error) {}
        } else {
          pOnPopUp.textContent = `${
            location.href.includes("/rental")
              ? "please choose drop off date greater than pick up date"
              : "Bitte wählen Sie ein Abgabedatum, das größer ist als das Abholdatum"
          }`;
          resultsContainer.classList.remove("active");
          popUpContainer.classList.add("active");
          closePopUpScreen();
        }
      }
    } else {
      // work in alert
      resultsContainer.classList.remove("active");
      popUpContainer.classList.add("active");
      closePopUpScreen();
    }
  });
  checkFlag = 0;
});
