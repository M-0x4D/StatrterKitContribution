<script language="JavaScript" type="text/javascript">
    const openLocationButton = document.getElementById('open-location-button')
    const closeLocationIcon = document.getElementById('close-location-icon')
    const closeLocationButton = document.getElementById('close-location-button')
    const locationMessage = document.getElementById('location-message')
    const closeEditLocation = document.getElementById('close-edit-location')

    closeLocationButton.addEventListener('click', () => {
        location.reload();
    })

    closeLocationIcon.addEventListener('click', () => {
        location.reload();
    })

    function handleLocation(id, NameEN, NameDE) {
        document.getElementById("locationeditmodal").click();
        document.getElementById("locationId").value = id;
        document.getElementById("location-en").value = NameEN;
        document.getElementById("location-de").value = NameDE;
    }

    async function createLocation(event) {
        event.preventDefault()
        const createLocation = document.getElementById('create-location')
        const formInputs = createLocation.querySelectorAll('[name]')
        sendLocRequest(formInputs, '/create-location')
    }

    function updateLocation(event) {
        event.preventDefault()
        const updateLocation = document.getElementById('update-location')
        const formInputs = updateLocation.querySelectorAll('[name]')
        sendLocRequest(formInputs, '/update-location')
    }

    async function sendLocRequest(elements, url) {
        let formvalues = []

        const requestData = new FormData();
        requestData.set("io", "request");
        requestData.set("jtl_token", token);
        for (const input of elements) {
            if (!!input.value) {
                requestData.set(input.name, input.value);
                formvalues.push(input)

                if (formvalues.length === elements.length) {
                    const data = await fiber.post(url, requestData);

                    if (data.status === 206) {
                        locationMessage.textContent = data.data
                        closeEditLocation.click()
                        openLocationButton.click()
                    } else if (data.status === 201) {
                        locationMessage.textContent = data.data
                        openLocationButton.click()
                    }
                }
            }
        }
    }

    async function deleteLocation(event, id) {
        event.preventDefault()
        const requestData = new FormData();
        requestData.set("io", "request");
        requestData.set("jtl_token", token);
        requestData.set("id", id);
        const data = await fiber.post('/destroy-location', requestData);


        if (data.status === 204) {
            locationMessage.textContent = 'Location delete successfully'
            openLocationButton.click()
        }
    }
</script>