let token = document.querySelector('.jtl_token').value;
let locationProtocol = location.protocol;
let locationHost = location.host;
const defaultBaseUrl = locationProtocol + "//" + locationHost + "/admin/io.php";

const fiber = new Fiber(defaultBaseUrl);
fiber.set_headers({
  "Content-lang": "en",
  Accept: "application/json",
  "Jtl-Token": token,
});

const openCategoryButton = document.getElementById("open-category-button");
const closeCategoryIcon = document.getElementById("close-category-icon");
const closeCategoryButton = document.getElementById("close-category-button");
const categoryMessage = document.getElementById("category-message");
const closeEditCategory = document.getElementById("close-edit-category");

closeCategoryButton.addEventListener("click", () => {
  location.reload();
});

closeCategoryIcon.addEventListener("click", () => {
  location.reload();
});

function handleCategory(id, NameEN, NameDE) {
  document.getElementById("categoryeditmodal").click();
  document.getElementById("categoryId").value = id;
  document.getElementById("category-en").value = NameEN;
  document.getElementById("category-de").value = NameDE;
}

async function createCategory(event) {
  event.preventDefault();
  const createCategory = document.getElementById("create-category");
  const formInputs = createCategory.querySelectorAll("[name]");
  sendCategoryRequest(formInputs, "/create-category");
}

function updateCategory(event) {
  event.preventDefault();
  const updateCategory = document.getElementById("update-category");
  const formInputs = updateCategory.querySelectorAll("[name]");
  sendCategoryRequest(formInputs, "/update-category");
}

async function sendCategoryRequest(elements, url) {
  let formvalues = [];

  const requestData = new FormData();
  requestData.set("io", "request");
  requestData.set("jtl_token", token);
  for (const input of elements) {
    if (!!input.value) {
      requestData.set(input.name, input.value);
      formvalues.push(input);

      if (formvalues.length === elements.length) {
        const data = await fiber.post(url, requestData);

        if (data.status === 206) {
          categoryMessage.textContent = data.data;
          closeEditCategory.click();
          openCategoryButton.click();
        } else if (data.status === 201) {
          categoryMessage.textContent = data.data;
          openCategoryButton.click();
        }
      }
    }
  }
}

async function deleteCategory(event, id) {
  event.preventDefault();
  const requestData = new FormData();
  requestData.set("io", "request");
  requestData.set("jtl_token", token);
  requestData.set("id", id);
  const data = await fiber.post("/destroy-category", requestData);

  if (data.status === 204) {
    categoryMessage.textContent = "category delete successfully";
    openCategoryButton.click();
  }
}
