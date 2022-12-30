// start define pop-up
let errorMessagePopUpContainer = document.getElementById(
  "error-message-pop-up-container"
);
let errorMessagePopUpContent = document.getElementById(
  "error-message-pop-up-content"
);
let closeErrorMessagePopUpIcon = document.getElementById(
  "error-message-pop-up-icon"
);
let closeErrorMessagePopUpButton = document.getElementById(
  "error-message-pop-up-button"
);
let popUpErrorMessage = document.getElementById("error-message-message");

closeErrorMessagePopUpIcon?.addEventListener("click", () => {
  errorMessagePopUpContainer.classList.remove("active");
  errorMessagePopUpContent.classList.remove("active");
});

closeErrorMessagePopUpButton?.addEventListener("click", () => {
  errorMessagePopUpContainer.classList.remove("active");
  errorMessagePopUpContent.classList.remove("active");
});

// end define pop-up

let rentDurationDay;

// start work in price
let popUpContentChildContent;
let carObjDataSmarty = {};

let currency = document
  .getElementById("reservation-total")
  ?.getAttribute("data-cur");

let duration = document
  .getElementById("reservation-total")
  ?.getAttribute("data-dur");

let obgLocationId = document
  .getElementById("reservation-total")
  ?.getAttribute("data-loc");

let currencyName = document
  .getElementById("reservation-total")
  ?.getAttribute("data-nam");

if (
  location.href.includes("product-details") ||
  location.href.includes("produkt-details")
) {
  window.onload = () => {
    // ====================================================================================== new
    let startDateInput = document.getElementById("obj_pickup_date");
    let endDateInput = document.getElementById("obj_dropoff_date");

    let rentToDate = document.querySelectorAll(".rent-to-date");
    let rentFromDate = document.getElementById("rent-from-date");

    let changeLang = document.querySelector(
      "#shop-nav li.language-dropdown div.dropdown-menu a.active"
    );

    $(document)
      .ready(function () {
        $("#obj_pickup_date").datetimepicker({
          language: location.href.includes("/rental") ? "en" : "de",
          dateFormat: "d-m-yy",
          timeFormat: "HH:mm:ss",
          minDate: new Date(),
          pickSeconds: true,
          pick12HourFormat: false,
          onSelect: function (dateText) {
            console.log(
              "Selected date: " +
                dateText +
                "; input's current value: " +
                this.value
            );
          },
        });
      })
      .on("change", function () {
        rentFromDate.textContent = startDateInput.value;

        carObjDataSmarty["pick-up-date"] = startDateInput.value;

        calcNumberOfDay();
      });

    $(document)
      .ready(function () {
        $("#obj_dropoff_date").datetimepicker({
          language: location.href.includes("/rental") ? "en" : "de",
          dateFormat: "d-m-yy",
          timeFormat: "HH:mm:ss",
          minDate: new Date(),
          pickSeconds: true,
          pick12HourFormat: false,
          onSelect: function (dateText) {
            console.log(
              "Selected date: " +
                dateText +
                "; input's current value: " +
                this.value
            );
          },
        });
      })
      .on("change", function () {
        carObjDataSmarty["drop-off-date"] = endDateInput.value;

        rentToDate.forEach((e) => {
          e.textContent = endDateInput.value;
        });

        calcNumberOfDay();
      });

    // $("#obj_pickup_date")
    //   .datepicker({
    //     language: changeLang.getAttribute("data-iso") === "ger" ? "de" : "en",
    //     format: "dd-mm-yyyy",
    //     todayBtn: "linked",
    //     clearBtn: true,
    //     todayHighlight: true,
    //     toggleActive: true,
    //     autoclose: true,
    //     orientation: "bottom auto",
    //     startDate: new Date(),
    //     onSelect: function (dateText) {
    //       console.log(
    //         "Selected date: " +
    //           dateText +
    //           "; input's current value: " +
    //           this.value
    //       );
    //     },
    //   })
    //   .on("change", function () {
    //     rentFromDate.textContent = startDateInput.value;

    //     carObjDataSmarty["pick-up-date"] = startDateInput.value;

    //     calcNumberOfDay();
    //   });

    // $("#obj_dropoff_date")
    //   .datepicker({
    //     language: changeLang.getAttribute("data-iso") === "ger" ? "de" : "en",
    //     format: "dd-mm-yyyy",
    //     todayBtn: "linked",
    //     clearBtn: true,
    //     todayHighlight: true,
    //     toggleActive: true,
    //     autoclose: true,
    //     orientation: "bottom auto",
    //     startDate: new Date(),
    //     onSelect: function (dateText) {
    //       console.log(
    //         "Selected date: " +
    //           dateText +
    //           "; input's current value: " +
    //           this.value
    //       );
    //     },
    //   })
    //   .on("change", function () {
    //     carObjDataSmarty["drop-off-date"] = endDateInput.value;

    //     rentToDate.forEach((e) => {
    //       e.textContent = endDateInput.value;
    //     });

    //     calcNumberOfDay();
    //   });
    // ====================================================================================== new

    let reservationTotal;

    function calcNumberOfDay() {
      // let dropOff = carObjDataSmarty["drop-off-date"]?.split("-");
      // let pickUp = carObjDataSmarty["pick-up-date"]?.split("-");

      let dropOff = carObjDataSmarty["drop-off-date"]?.split(" ");
      let pickUp = carObjDataSmarty["pick-up-date"]?.split(" ");

      if (Object.keys(carObjDataSmarty).length === 2) {
        if (
          new Date(
            `${pickUp[0].split("-")[1]}-${pickUp[0].split("-")[0]}-${
              pickUp[0].split("-")[2]
            } ${pickUp[1]}`
          ) >
          new Date(
            `${dropOff[0].split("-")[1]}-${dropOff[0].split("-")[0]}-${
              dropOff[0].split("-")[2]
            } ${dropOff[1]}` || ""
          )
        ) {
          endDateInput.value = "";

          popUpErrorMessage.textContent = `${
            changeLang.getAttribute("data-iso") === "ger"
              ? "Bitte wählen Sie ein Abgabedatum, das größer ist als das Abholdatum"
              : "please choose drop off date greater than pick up date"
          }`;
          errorMessagePopUpContainer.classList.add("active");
          errorMessagePopUpContent.classList.add("active");
        } else {
          let rantPrice = document.getElementById("rant-price").textContent;

          let d1Base = carObjDataSmarty["pick-up-date"]
            .replaceAll("-", "/")
            .split("/");

          let d2Base = carObjDataSmarty["drop-off-date"]
            .replaceAll("-", "/")
            .split("/");

          let d1 = new Date(d1Base[1] + "/" + d1Base[0] + "/" + d1Base[2]);
          let d2 = new Date(d2Base[1] + "/" + d2Base[0] + "/" + d2Base[2]);

          rentDurationDay = (d2 - d1) / (1000 * 60 * 60 * 24) + 1;

          let rentTd = document.getElementById("all-days-descriptions");
          rentTd.innerHTML = "";

          reservationTotal =
            +rantPrice * (+rentDurationDay === 0 ? 1 : +rentDurationDay) +
            ` ${currencyName.toUpperCase()}`;

          for (let i = 0; i < rentDurationDay; i++) {
            let tr = document.createElement("tr");
            let td1 = document.createElement("td");
            if (i == 0) {
              td1.textContent = new Date(d1.setDate(d1.getDate()))
                .toString()
                .slice(0, 15);
            } else {
              td1.textContent = new Date(d1.setDate(d1.getDate() + 1))
                .toString()
                .slice(0, 15);
            }

            tr.appendChild(td1);

            let td2 = document.createElement("td");
            td2.textContent = rantPrice + " EUR";
            tr.appendChild(td2);
            rentTd.appendChild(tr);
          }

          dayRentalPrice = reservationTotal;

          let x = document.createElement("tr");
          x.setAttribute("class", "font-table-price");

          xtd = document.createElement("td");

          xtd.textContent =
            changeLang.getAttribute("data-iso") === "ger"
              ? "Gesamtpreis"
              : "Total price";
          x.appendChild(xtd);

          xtd2 = document.createElement("td");
          xtd2.setAttribute(
            "class",
            "item-combonent-rent-price font-table-price total-rent-price"
          );
          xtd2.innerHTML = reservationTotal;
          x.appendChild(xtd2);

          rentTd.appendChild(x);

          document.getElementById("reservation-total").textContent =
            reservationTotal;
          let allRentPrice = document.querySelector(".all-total-rent-price");
          allRentPrice.textContent = reservationTotal;
        }
      }
    }

    // ===================================================================

    let rentExtraItems = document.querySelectorAll(".extra-items");

    rentExtraItems.forEach((e, i, arr) => {
      if (e.value == 0) {
        extraCombonentRentPrice.forEach((e) => {
          e.querySelector("span.care").textContent =
            changeLang.getAttribute("data-iso") === "ger"
              ? "Keine zusätzlichen Elemente"
              : "No extra items";
        });
      }

      e.addEventListener("click", () => {
        defaultPopupElement();

        let t = 0;
        let m = 0;

        for (let num = 0; num < arr.length; num++) {
          extra +=
            +document.querySelectorAll(".extra-items")[num].value *
            +document
              .querySelectorAll(".extra-items")
              [num].getAttribute("data-need");

          t +=
            +document.querySelectorAll(".extra-items")[num].value *
            +document
              .querySelectorAll(".extra-items")
              [num].getAttribute("data-need");

          m++;

          if (m === arr.length) {
            m = 0;
            priceFeatures = t;
          }
        }

        extraCombonentRentPrice.forEach((e) => {
          e.querySelector("span.amou").innerHTML = t;
        });

        extraCombonentRentPrice.forEach((e) => {
          e.querySelector("span.care").textContent = "EUR";
        });
      });
    });

    let resetExtraItem = document.getElementById("reset-all-extra-item");

    resetExtraItem.addEventListener("click", () => {
      defaultPopupElement();

      document.getElementById("reservation-total").textContent =
        changeLang.getAttribute("data-iso") === "ger"
          ? "Datum wählen"
          : "Choose Date";

      rentToDate.forEach((e) => {
        e.textContent =
          changeLang.getAttribute("data-iso") === "ger"
            ? "Datum wählen"
            : "Choose Date";
      });

      document.querySelector(".all-total-rent-price").textContent =
        changeLang.getAttribute("data-iso") === "ger"
          ? "Datum wählen"
          : "Choose Date";

      let rentTd = document.getElementById("all-days-descriptions");
      rentTd.innerHTML =
        changeLang.getAttribute("data-iso") === "ger"
          ? `<td colspan="2" class="text-center">Datum wählen</td>`
          : `<td colspan="2" class="text-center">Choose Date</td>`;

      carObjDataSmarty = {};
      document.getElementById("obj_pickup_date").value = "";
      document.getElementById("obj_dropoff_date").value = "";

      dayRentalPrice = null;
    });
  };
}
// end work in price

// =====================================================

// start work in rental-proceed button
if (
  location.href.includes("product-details") ||
  location.href.includes("produkt-details")
) {
  let rentalProceed = document.getElementById("rental-proceed");
  let popUpIcon = document.getElementById("pop-up-icon");
  let confirmButton = document.getElementById("confirm-pop-up-screen");

  rentalProceed.addEventListener("click", () => {
    if (!!dayRentalPrice) {
      let y = dayRentalPrice.split(" ")[1];
      let x = +dayRentalPrice.split(" ")[0];

      popUpIcon.setAttribute(
        "src",
        "/mediafiles/Resources/Photos/exclamation-mark.svg"
      );

      pOnPopUp.innerHTML =
        changeLang.getAttribute("data-iso") === "ger"
          ? `<span>Sind Sie sicher, dass Sie dieses Produkt buchen möchten?</span>
            <span>Der Mietpreis beträgt: <span id='rent-price-car'>${x} ${y}</span></span>`
          : `<span>are yo sure you want to book this product</span>
            <span>rental price is: <span id='rent-price-car'>${x} ${y}</span></span>`;

      let rentPriceCar = document.getElementById("rent-price-car");
      if (!!rentPriceCar) {
        rentPriceCar.innerHTML = `${x} ${y}`;
      }

      confirmButton.classList.add("active");
      popUpContainer.classList.add("active");

      closePopUpScreen();

      // close popup screen

      // close popup screen

      popUpContentChildContent = document.getElementById(
        "pop-up-content-child"
      ).innerHTML;

      let confermButtonRental = document.getElementById(
        "confirm-pop-up-screen"
      );
      let closePopUpScreenButton = document.getElementById(
        "close-pop-up-screen"
      );

      closePopUpScreenButton?.addEventListener("click", () => {
        popUpContainer.classList.remove("active");
      });

      let bookUrlForRent = `/book-object`;

      if (!!confermButtonRental) {
        confermButtonRental.addEventListener("click", async () => {
          let dumData = JSON.parse(localStorage.getItem("dumData"));

          let carRentData = {
            pickupDate: carObjDataSmarty["pick-up-date"],
            dropOffDate: carObjDataSmarty["drop-off-date"],
            currency_id: currency,
            // totalAmount: +dayRentalPrice.split(" ")[0],
            no_of_days: rentDurationDay,
            objectId: dumData.cDumData.split("#")[0],
            // duration: duration,
            location_id: obgLocationId,
          };

          popUpContentChild.innerHTML = `
                <img src="/mediafiles/Resources/Photos/loading.svg" alt="loading-img" class='rental-loading-img'>
              `;

          const data = new FormData();
          data.set("io", "request");
          data.set("jtl_token", fetchToken);
          if (!!carRentData["pickupDate"]) {
            data.set("pickup_date", carRentData["pickupDate"]);
          }
          if (!!carRentData["dropOffDate"]) {
            data.set("dropOff_date", carRentData["dropOffDate"]);
          }
          if (!!carRentData["currency_id"]) {
            data.set("currency_id", carRentData["currency_id"]);
          }
          // if (
          //   !!carRentData["totalAmount"] ||
          //   +carRentData["totalAmount"] === 0
          // ) {
          //   data.set("total_amount", carRentData["totalAmount"]);
          // }

          if (!!carRentData["no_of_days"]) {
            data.set("no_of_days", carRentData["no_of_days"]);
          }

          if (!!carRentData["objectId"]) {
            data.set("object_id", carRentData["objectId"]);
          }
          // if (!!carRentData["duration"]) {
          //   data.set("duration", carRentData["duration"]);
          // }

          if (!!carRentData["location_id"]) {
            data.set("location_id", carRentData["location_id"]);
          }

          try {
            const response = await fiberForPayment.post(
              `${bookUrlForRent}`,
              data
            );
            if (response.status === 201) {
              popUpContentChild.innerHTML =
                changeLang.getAttribute("data-iso") === "ger"
                  ? `
                      <p class='proceed-message'>Zahlung veranlassen</p>
                      <div>
                        <a class="pop-up-button" href=${response.data.data}
                            style="background-color: #25c6da;">Bestätigen</a>
                        <button class="pop-up-button" id="close-pop-up-screen">Schließen</button>
                      </div>
                    `
                  : `
                  <p class='proceed-message'>proceed payment</p>
                  <div>
                    <a class="pop-up-button" href=${response.data.data}
                        style="background-color: #25c6da;">confirm</a>
                    <button class="pop-up-button" id="close-pop-up-screen">close</button>
                  </div>
                `;
            } else {
              popUpContentChild.innerHTML =
                changeLang.getAttribute("data-iso") === "ger"
                  ? `
                  <p class='proceed-message'>Es ist ein Problem aufgetreten, bitte versuchen Sie es später noch einmal</p>
                  <div>
                    <button class="pop-up-button" id="close-pop-up-screen">Schließen</button>
                  </div>
                  `
                  : `
    
                <p class='proceed-message'>there is a problem please try again later</p>
                <div>
                  <button class="pop-up-button" id="close-pop-up-screen">close</button>
                </div>
              `;

              // console.clear();
            }

            let closePopUpScreenButton = document.getElementById(
              "close-pop-up-screen"
            );

            closePopUpScreenButton.addEventListener("click", () => {
              popUpContainer.classList.remove("active");
              defaultPopupElement();
            });

            let closeRentalPopup = document.getElementById(
              "close-rental-car-popup"
            );

            closeRentalPopup.addEventListener("click", () => {
              defaultPopupElement();
            });
          } catch (error) {}
        });
      }
    } else {
      popUpErrorMessage.textContent = `${
        changeLang.getAttribute("data-iso") === "ger"
          ? "Bitte wählen Sie zuerst das Datum"
          : "Please choose date first"
      }`;
      errorMessagePopUpContainer.classList.add("active");
      errorMessagePopUpContent.classList.add("active");
    }
  });
}
// end work in rental-proceed button

// ==================================================================
// start work in sort by date in my rentals
if (
  location.href.includes("my-rentals") ||
  location.href.includes("meine-vermietungen")
) {
  let sortRentByDate = document.querySelectorAll(".sort-rent-by-date");

  let rentalUrlFetch = `/filter-rentals-by-date`;

  let customerId = document
    .getElementById("container-for-features-and-search-my-rental")
    .getAttribute("data-u-i");

  let filterTypeData = {};
  filterTypeData.customerId = customerId;

  sortRentByDate.forEach((e) => {
    e.addEventListener("click", async () => {
      let dateAtt = e.getAttribute("date-rent-filter");

      if (dateAtt === "ASC") {
        filterTypeData.filter = "ASC";
      } else if (dateAtt === "DESC") {
        filterTypeData.filter = "DESC";
      }

      const data = new FormData();
      data.set("io", "request");
      data.set("jtl_token", fetchToken);

      for (const [key, value] of Object.entries(filterTypeData)) {
        data.set(key, value);
      }

      try {
        const response = await fiberForPayment.post(`${rentalUrlFetch}`, data);
        if (response.status === 200) {
          let da = response.data;
          makeHtmlElement(da, false);
        }
      } catch (error) {}
    });
  });
}
// end work in sort by date in my rentals

// ========================= for clear old data
// function removeDataBeforeGo() {
//   localStorage.removeItem("dumData");
// }
if (
  !localStorage.getItem("dumData") &&
  (location.href.includes("product-details") ||
    location.href.includes("produkt-details"))
) {
  if (changeLang.getAttribute("data-iso") === "ger") {
    location.href = `vermietung`;
  } else if (changeLang.getAttribute("data-iso") === "eng") {
    location.href = `rental`;
  }
}
// ========================= for clear old data
