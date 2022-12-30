const openCurrencyButton = document.getElementById("open-currency-button");
const closeCurrencyIcon = document.getElementById("close-currency-icon");
const closeCurrencyButton = document.getElementById("close-currency-button");
const currencyMessage = document.getElementById("currency-message");
const closeEditCurrency = document.getElementById("close-edit-currency");

closeCurrencyButton.addEventListener("click", () => {
  location.reload();
});

closeCurrencyIcon.addEventListener("click", () => {
  location.reload();
});

function handleCurrency(id, NameEN, currency_code) {
  document.getElementById("currencyeditmodal").click();
  document.getElementById("currencyId").value = id;
  document.getElementById("currency-en").value = NameEN;
  document.getElementById("currency-code").value = currency_code;
}

async function createCurrency(event) {
  event.preventDefault();
  const createCurrency = document.getElementById("create-currency");
  const formInputs = createCurrency.querySelectorAll("[name]");
  sendCurRequest(formInputs, "/create-currency");
}

function updateCurrency(event) {
  event.preventDefault();
  const updateCurrency = document.getElementById("update-currency");
  const formInputs = updateCurrency.querySelectorAll("[name]");
  sendCurRequest(formInputs, "/update-currency");
}

async function sendCurRequest(elements, url) {
  let formValues = [];

  const requestData = new FormData();
  requestData.set("io", "request");
  requestData.set("jtl_token", token);
  for (const input of elements) {
    if (!!input.value) {
      requestData.set(input.name, input.value);
      formValues.push(input);

      if (formValues.length === elements.length) {
        try {
          const data = await fiber.post(url, requestData);

          if (data.status === 206) {
            currencyMessage.textContent = data.data;
            closeEditCurrency.click();
            openCurrencyButton.click();
          } else if (data.status === 201) {
            closeEditCurrency.click();
            currencyMessage.textContent = data.data;
            openCurrencyButton.click();
          }
        } catch (error) {
            currencyMessage.textContent = 'error while sending data';
            openCurrencyButton.click();
        }
      }
    }
  }
}

async function deleteCurrency(id) {
  event.preventDefault();
  const requestData = new FormData();
  requestData.set("io", "request");
  requestData.set("jtl_token", token);
  requestData.set("currency_id", id);
  const data = await fiber.post("/destroy-currency", requestData);

  if (data.status === 204) {
    currencyMessage.textContent = "currency delete successfully";
    openCurrencyButton.click();
  }
}
