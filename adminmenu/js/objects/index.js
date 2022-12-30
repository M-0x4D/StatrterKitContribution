// ======================= modal
const openObjectModal = document.getElementById("add-new-oject");
const closeObjectModalIcon = document.getElementById("close-add-object-modal");
const closeObjectModalButton = document.getElementById("close-add-new-oject");
const messageObjectModal = document.getElementById(
  "add-object-request-messages"
);
// ======================= modal
closeObjectModalIcon.addEventListener("click", () => {
  if (closeFlag) {
    closeObjectModalIcon.click();
  } else {
    closeObjectModalIcon.click();
    location.reload();
  }
});

closeObjectModalButton.addEventListener("click", () => {
  if (closeFlag) {
    closeObjectModalIcon.click();
  } else {
    closeObjectModalIcon.click();
    location.reload();
  }
});

function addNewObject(event) {
  event.preventDefault();

  const addNewObjectForm = document.getElementById("add-new-object-form");
  const allInputsNewObjectForm = addNewObjectForm.querySelectorAll(
    "[name]:not([name~='custom_features_input'])"
  );

  sendObjectRequest(allInputsNewObjectForm, "/create-object");
}

async function sendObjectRequest(elements, url) {
  let formValues = [];

  const requestData = new FormData();
  requestData.set("io", "request");
  requestData.set("jtl_token", token);
  for (const input of elements) {
    if (!!input.value) {
      if (
        input.name !== "image" &&
        input.name !== "images" &&
        input.name !== "additional_features"
      ) {
        requestData.set(input.name, input.value);
      } else if (input.name === "image") {
        requestData.set(input.name, input.files[0]);
      } else if (input.name === "images") {
        for (const file of Object.entries(input.files)) {
          requestData.set(`${input.name}[${file[0]}]`, file[1]);
        }
      } else if (input.name === "additional_features") {
        for (const feature of JSON.parse(input.value).entries()) {
          for (const key of Object.entries(feature[1])) {
            requestData.set(`${input.name}[${feature[0]}][${key[0]}]`, key[1]);
          }
        }
      }

      formValues.push(input);
    } else if (input.value === "" && input.name === "additional_features") {
      formValues.push(input);
    }

    try {
      if (formValues.length === elements.length) {
        const data = await fiber.post(url, requestData);

        document.getElementById("close-promotion-update-modal").click();
        messageObjectModal.textContent = "object add successfully";
        openObjectModal.click();

        closeFlag = false;
      }
    } catch (error) {
      console.log(error);
    }
  }
}

const additionalInputsControllers = document.getElementById(
  "additional_inputs_controllers"
);
const additionalFeaturesName = document.getElementById(
  "additional-features-name"
);
const additionalFeaturesType = document.getElementById(
  "additional-features-type"
);

additionalFeaturesType.addEventListener("change", () => {
  let addButton = document.getElementById("add-additional-features");
  let valueParent = document.getElementById("additional-features-value-parent");

  addButton?.remove();
  valueParent?.remove();

  let div = document.createElement("div");
  div.setAttribute("id", "additional-features-value-parent");

  let label = document.createElement("label");
  label.setAttribute("for", "additional-features-value");
  label.textContent = "features value";
  div.appendChild(label);

  switch (additionalFeaturesType.value) {
    case "string":
      let input = document.createElement("input");
      input.setAttribute("id", "additional-features-value");
      input.setAttribute("type", "text");
      input.setAttribute("name", "custom_features_input");
      input.setAttribute("placeholder", "type additional features value");
      div.appendChild(input);
      break;

    case "integer":
      let number = document.createElement("input");
      number.setAttribute("id", "additional-features-value");
      number.setAttribute("type", "number");
      number.setAttribute("name", "custom_features_input");
      number.setAttribute("placeholder", "type additional features value");
      div.appendChild(number);
      break;

    case "text":
      let textarea = document.createElement("textarea");
      textarea.setAttribute("id", "additional-features-value");
      textarea.setAttribute("name", "custom_features_input");
      textarea.setAttribute("placeholder", "type additional features value");
      textarea.setAttribute("rows", "4");
      // textarea.setAttribute("cols", "50");
      textarea.setAttribute("style", "resize: none");
      div.appendChild(textarea);
      break;
  }

  additionalInputsControllers.appendChild(div);

  let add = document.createElement("button");
  add.setAttribute("id", "add-additional-features");
  add.setAttribute("onclick", "addNewFeatures(event)");

  add.textContent = "add";

  additionalInputsControllers.appendChild(add);
});

let allNewFeaturesArray = [];
const additionalFeaturesInput = document.getElementById(
  "additional-features-array"
);

let closeFlag = false;

function addNewFeatures(event) {
  event.preventDefault();

  const allAdditionalInputs = document.querySelectorAll(
    "#additional_inputs_controllers [name='custom_features_input']"
  );

  let flag = [];

  allAdditionalInputs.forEach((input, index, arr) => {
    if (!!input.value) {
      flag.push(input.value);

      if (flag.length === arr.length) {
        let dataObject = {};

        dataObject.name = additionalFeaturesName.value;
        dataObject.type = additionalFeaturesType.value;
        dataObject.value = document.getElementById(
          "additional-features-value"
        ).value;
        allNewFeaturesArray.push(dataObject);

        additionalFeaturesInput.value = JSON.stringify(allNewFeaturesArray);

        additionalFeaturesName.value = "";
        document.getElementById("additional-features-value").value = "";

        let additionalInputs = document.getElementById("additional_inputs");
        displayNewData(allNewFeaturesArray, additionalInputs, true);
      }
    } else if (index + 1 === arr.length) {
      messageObjectModal.textContent =
        "please fill all additional features inputs fields";
      openObjectModal.click();

      closeFlag = true;
    }
  });
}

function displayNewData(allNewFeaturesArray, additionalInputs, flag) {
  additionalInputs.innerHTML = "";

  if (allNewFeaturesArray.length > 0) {
    for (let index = 0; index < allNewFeaturesArray.length; index++) {
      let tr = document.createElement("tr");

      let allTd = [];

      for (const [key, value] of Object.entries(allNewFeaturesArray[index])) {
        let td = document.createElement("td");

        switch (key) {
          case "name":
            td.textContent = value;
            allTd[1] = td;
            break;

          case "value":
            td.textContent = value;
            allTd[3] = td;
            break;

          case "type":
            td.textContent =
              value === "integer"
                ? "number"
                : value === "string"
                ? "text"
                : value === "text"
                ? "textarea"
                : "";
            allTd[2] = td;
            break;
        }
      }

      let td = document.createElement("td");
      td.textContent = index + 1;
      tr.appendChild(td);

      allTd.forEach((td) => {
        tr.appendChild(td);
      });

      let tdButton = document.createElement("td");
      let button = document.createElement("button");
      button.textContent = "delete";
      button.setAttribute("class", "btn btn-danger tecSee-button-delete");

      if (flag) {
        button.setAttribute("onclick", `deleteAdFeatures(${index})`);
      } else {
        button.setAttribute("onclick", `deleteUpdateAdFeatures(${index})`);
      }

      tdButton.appendChild(button);
      tr.appendChild(tdButton);

      additionalInputs.appendChild(tr);
    }
  } else {
    additionalInputs.innerHTML = `
      <tr>
          <td class="text-center" colspan="5">there is no data</td>
      <tr>
    `;
  }
}

function deleteAdFeatures(index) {
  event.preventDefault();

  allNewFeaturesArray.splice(index, 1);

  additionalFeaturesInput.value = JSON.stringify(allNewFeaturesArray);

  let additionalInputs = document.getElementById("additional_inputs");
  displayNewData(allNewFeaturesArray, additionalInputs, true);
}

// =============================== delete object
const allDeleteButton = document.querySelectorAll("button.DeleteObject");

allDeleteButton.forEach((button) => {
  button.addEventListener("click", async (event) => {
    let id = +button.getAttribute("data-object");

    const requestData = new FormData();
    requestData.set("io", "request");
    requestData.set("jtl_token", token);
    requestData.set("id", id);

    try {
      const data = await fiber.post("/destroy-object", requestData);

      messageObjectModal.textContent = "object delete successfully";
      openObjectModal.click();

      closeFlag = false;
    } catch (error) {
      console.log(error);
    }
  });
});

// ================================== update object
const objectUpdateModal = document.getElementById("ojectEditModelButton");

const updateNameEnObj = document.getElementById("update-nameEn");
const updateNameDeObj = document.getElementById("update-nameDe");
const updatePriceObj = document.getElementById("update-price");
// const updateQuantity = document.getElementById("update-quantity);
const updateDurationObj = document.getElementById("update-duration-obj");
const updateColorObj = document.getElementById("update-color-obj");
const updateLocationObj = document.getElementById("update-location-obj");
const updateCategoryObj = document.getElementById("update-category-obj");
const updateLongDescriptionEnObj = document.getElementById(
  "update_long_description_en"
);
const updateLongDescriptionDeObj = document.getElementById(
  "update_long_description_de"
);
const updateShortDescriptionEnObj = document.getElementById(
  "update_short_description_en"
);
const updateShortDescriptionDeObj = document.getElementById(
  "update_short_description_de"
);

const updateIncludesEn = document.getElementById("update_includes_en");
const updateIncludesDe = document.getElementById("update_includes_de");
const updateExcludesEn = document.getElementById("update_excludes_en");
const updateExcludesDe = document.getElementById("update_excludes_de");

const updateAdditionalInputs = document.getElementById(
  "update_additional_inputs"
);

const updateAdditionalFeaturesArray = document.getElementById(
  "update-additional-features-array"
);

let allOldData;

function openObjectUpdateModel(oldData) {
  allOldData = oldData;

  updateNameEnObj.value = oldData.objectNameDE;
  updateNameDeObj.value = oldData.objectNameDE;
  updatePriceObj.value = oldData.price;
  // updateQuantity.value = oldData.quantity
  updateDurationObj.value = oldData.duration;
  updateColorObj.value = oldData.color_id;
  updateLocationObj.value = oldData.location_id;
  updateCategoryObj.value = oldData.category_id;
  updateLongDescriptionEnObj.value = oldData.longDescription.en;
  updateLongDescriptionDeObj.value = oldData.longDescription.de;
  updateShortDescriptionEnObj.value = oldData.shortDescription.en;
  updateShortDescriptionDeObj.value = oldData.shortDescription.de;

  updateIncludesEn.value = oldData.priceIncludesEN;
  updateIncludesDe.value = oldData.priceIncludesDE;
  updateExcludesEn.value = oldData.priceExcludesEN;
  updateExcludesDe.value = oldData.priceExcludesDE;

  updateAdditionalFeaturesArray.value = JSON.stringify(oldData.labels);

  displayNewData(oldData.labels, updateAdditionalInputs, false);

  objectUpdateModal.click();
}

function deleteUpdateAdFeatures(index) {
  event.preventDefault();

  let allNewFeaturesArray = JSON.parse(updateAdditionalFeaturesArray.value);

  allNewFeaturesArray.splice(index, 1);

  updateAdditionalFeaturesArray.value = JSON.stringify(allNewFeaturesArray);

  displayNewData(allNewFeaturesArray, updateAdditionalInputs, false);
}

const updateObjForm = document.getElementById("update-object-form");
const allUpdateObgInputs = updateObjForm.querySelectorAll(
  "[name]:not([name~='update_custom_features_input'])"
);

async function updateObject(event) {
  // console.log(allOldData);

  event.preventDefault();

  let formValues = [];

  const requestData = new FormData();
  requestData.set("io", "request");
  requestData.set("jtl_token", token);
  requestData.set("id", allOldData.id);

  for (const input of allUpdateObgInputs) {
    if (!!input.value) {
      if (input.name !== "image" && input.name !== "additional_features") {
        requestData.set(input.name, input.value);
      } else if (input.name === "image") {
        requestData.set(input.name, input.files[0]);
      } else if (input.name === "additional_features") {
        for (const feature of JSON.parse(input.value).entries()) {
          for (const key of Object.entries(feature[1])) {
            if (key[0] === "name") {
              requestData.set(
                `${input.name}[${feature[0]}][${key[0]}]`,
                key[1]
              );
            } else if (key[0] === "type") {
              requestData.set(
                `${input.name}[${feature[0]}][${key[0]}]`,
                key[1]
              );
            } else if (key[0] === "value") {
              requestData.set(
                `${input.name}[${feature[0]}][${key[0]}]`,
                key[1]
              );
            }
          }
        }
      }

      formValues.push(input);
    } else if (input.value === "" && input.name === "additional_features") {
      formValues.push(input);
    }
    // else {
    //   if (input.name === "image") {
    //     formValues.push(input);
    //   }
    // }
  }

  // console.log(formValues.length, allUpdateObgInputs.length);

  try {
    if (formValues.length === allUpdateObgInputs.length) {
      const data = await fiber.post("/update-object", requestData);

      document.getElementById("close-promotion-update-modal").click();
      messageObjectModal.textContent = "object update successfully";
      openObjectModal.click();

      closeFlag = false;
    }
  } catch (error) {
    console.log(error);
  }
}

const updateAdditionalFeaturesType = document.getElementById(
  "update-additional-features-type"
);

const updateAdditionalInputsControllers = document.getElementById(
  "update_additional_inputs_controllers"
);

updateAdditionalFeaturesType.addEventListener("change", () => {
  let addButton = document.getElementById("add-update-additional-features");
  let valueParent = document.getElementById(
    "update-additional-features-value-parent"
  );

  addButton?.remove();
  valueParent?.remove();

  let div = document.createElement("div");
  div.setAttribute("id", "update-additional-features-value-parent");

  let label = document.createElement("label");
  label.setAttribute("for", "additional-features-value");
  label.textContent = "features value";
  div.appendChild(label);

  switch (updateAdditionalFeaturesType.value) {
    case "string":
      let input = document.createElement("input");
      input.setAttribute("id", "update-additional-features-value");
      input.setAttribute("type", "text");
      input.setAttribute("name", "update_custom_features_input");
      input.setAttribute("placeholder", "type additional features value");
      div.appendChild(input);
      break;

    case "integer":
      let number = document.createElement("input");
      number.setAttribute("id", "update-additional-features-value");
      number.setAttribute("type", "number");
      number.setAttribute("name", "update_custom_features_input");
      number.setAttribute("placeholder", "type additional features value");
      div.appendChild(number);
      break;

    case "text":
      let textarea = document.createElement("textarea");
      textarea.setAttribute("id", "update-additional-features-value");
      textarea.setAttribute("name", "update_custom_features_input");
      textarea.setAttribute("placeholder", "type additional features value");
      textarea.setAttribute("rows", "4");
      // textarea.setAttribute("cols", "50");
      textarea.setAttribute("style", "resize: none");
      div.appendChild(textarea);
      break;
  }

  updateAdditionalInputsControllers.appendChild(div);

  let add = document.createElement("button");
  add.setAttribute("id", "add-update-additional-features");
  add.setAttribute("onclick", "addNewUpdateFeatures(event)");

  add.textContent = "add";

  updateAdditionalInputsControllers.appendChild(add);
});

const additionalFeaturesNameUpdate = document.getElementById(
  "update-additional-features-name"
);
const additionalFeaturesTypeUpdate = document.getElementById(
  "update-additional-features-type"
);

let updateAllNewFeaturesArray = [];

function addNewUpdateFeatures(event) {
  event.preventDefault();

  const allAdditionalInputs = document.querySelectorAll(
    "#update_additional_inputs_controllers [name='update_custom_features_input']"
  );

  let flag = [];

  allAdditionalInputs.forEach((input, index, arr) => {
    updateAllNewFeaturesArray = JSON.parse(updateAdditionalFeaturesArray.value);
    if (!!input.value) {
      flag.push(input.value);

      if (flag.length === arr.length) {
        let dataObject = {};

        dataObject.name = additionalFeaturesNameUpdate.value;
        dataObject.type = additionalFeaturesTypeUpdate.value;
        dataObject.value = document.getElementById(
          "update-additional-features-value"
        ).value;
        updateAllNewFeaturesArray.push(dataObject);

        updateAdditionalFeaturesArray.value = JSON.stringify(
          updateAllNewFeaturesArray
        );

        additionalFeaturesNameUpdate.value = "";
        document.getElementById("update-additional-features-value").value = "";

        let additionalInputs = document.getElementById(
          "update_additional_inputs"
        );

        displayNewData(updateAllNewFeaturesArray, additionalInputs, false);
      }
    } else if (index + 1 === arr.length) {
      messageObjectModal.textContent =
        "please fill all additional features inputs fields";
      openObjectModal.click();

      closeFlag = true;
    }
  });
}
