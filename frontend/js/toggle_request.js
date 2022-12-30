// start work in global variable
// start jtl token
let fetchToken;

if (
  location.href.includes("product-details") ||
  location.href.includes("produkt-details") ||
  location.href.includes("rental") ||
  location.href.includes("vermietung")
) {
  let tokenContainer = document.querySelector(
    ".container-for-features-and-search"
  );

  let fetchTokenData = tokenContainer.getAttribute("data-token");
  if (!!fetchTokenData) {
    fetchToken = fetchTokenData.slice(
      fetchTokenData.indexOf("value") + 7,
      fetchTokenData.lastIndexOf('"')
    );
  }
}

// ==================================== new request using fiber js
const paymentBaseUrl = `${location.protocol}//${location.host}/io.php`;
const fiberForPayment = new Fiber(paymentBaseUrl);
fiberForPayment.set_headers({
  "Content-lang": "en",
  Accept: "application/json",
  "Jtl-Token": fetchToken,
});

