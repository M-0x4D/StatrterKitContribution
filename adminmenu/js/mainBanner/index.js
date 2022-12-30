async function createBanner(event) {
  event.preventDefault();
  const createBanner = document.getElementById("create-main-banner");
  const formInputs = createBanner.querySelectorAll("[name]");
  sendBanRequest(formInputs, "/create-banar");
}

function updateBanner(event) {
  event.preventDefault();
  const updateBanner = document.getElementById("update-banner");
  const formInputs = updateBanner.querySelectorAll("[name]");
  sendBanRequest(formInputs, "/update-banar");
}

const bannerEditModal = document.getElementById("bannerEditModalButton");
const closeBannerUpdate = document.getElementById("close-banner-icon");

const bannerMessage = document.getElementById("banner-message");
const openBannerButton = document.getElementById("open-banner-button");

const closeBannerIcon = document.getElementById("close-message-banner-icon");
const closeBannerButton = document.getElementById("close-banner-button");

let bannerId;
let reloadFlag = false;

function handleBannerImage(id) {
  bannerEditModal.click();
  bannerId = id;
}

async function sendBanRequest(elements, url) {
  let formValues = [];

  const requestData = new FormData();
  requestData.set("io", "request");

  if (url === "/update-banar") {
    requestData.set("id", bannerId);
  }

  for (const input of elements) {
    if (!!input.value) {
      if (input.name === "banner") {
        requestData.set(input.name, input.files[0]);
      } else {
        requestData.set(input.name, input.value);
      }
      formValues.push(input);

      if (formValues.length === elements.length) {
        try {
          const data = await fiber.post(url, requestData);

          if (data.status === 404) {
            bannerMessage.textContent = data.errors;
            closeBannerUpdate.click();
            openBannerButton.click();
          } else {
            if (url === "/update-banar") {
              bannerMessage.textContent = "banner update successful";
            } else {
              bannerMessage.textContent = "banner add successful";
            }
            closeBannerUpdate.click();
            openBannerButton.click();
          }

          reloadFlag = false;
        } catch (error) {
          bannerMessage.textContent = "there is an error";
          closeBannerUpdate.click();
          openBannerButton.click();

          reloadFlag = true;
        }
      }
    }
  }
}

closeBannerIcon.addEventListener("click", () => {
  location.reload();
});
closeBannerButton.addEventListener("click", () => {
  location.reload();
});

async function deleteBannerImage(id) {
  const requestData = new FormData();
  requestData.set("io", "request");
  requestData.set("jtl_token", token);
  requestData.set("id", id);
  const data = await fiber.post("/destroy-banner", requestData);

  if (data.status === 204) {
    bannerMessage.textContent = "Banner delete successfully";
    openBannerButton.click();
  }
}
