{include file="../layout/tecsee_styles.tpl"}

<h2 class="trainer-name">Plugin Mode/Plugin-Modus</h2>
<hr />

<div class="tecSee-padding">
    <input form="add-credential" class="paypal-mode" required type="radio" id="PAYPAL_LIVE" name="paypal-mode"
        value="PAYPAL_LIVE" onchange="sendMode('PAYPAL_LIVE')">
    <label for="PAYPAL_LIVE">live Mode</label>
    <br>
    <input form="add-credential" class="paypal-mode" required type="radio" id="PAYPAL_SAND_BOX" name="paypal-mode"
        value="PAYPAL_SAND_BOX" onchange="sendMode('PAYPAL_SAND_BOX')">
    <label for="PAYPAL_SAND_BOX">Sand Box Mode</label>
</div>

<h2 class="trainer-name">
    This data is used for business account</h2>
<hr />

<form id="add-credential" class="tecSee-form" onsubmit="createCredentials(event)" method="POST" autocomplete="off"
    enctype="multipart/form-data">
    {$jtl_token}
    <div>
        <label>Business account/Business-Konto</label>
        <input type="text" name="business_account"
            placeholder="Write your business account/Schreiben sie ihre Business-Konto" required>
    </div>

    <div>
        <label>Client Id/Kunden-ID</label>
        <input type="text" name="client_id" placeholder="Write your client id/Schreiben Sie Ihre Kunden-ID" required>
    </div>

    <div class="full-width">
        <label>Secret Key/Geheimcode</label>
        <input type="text" name="secret_key" placeholder="Write your secret key/Schreiben Sie Ihren Geheimcode"
            required>
    </div>

    <input type="submit" value="Create">
</form>

<hr />

<form class="tecSee-form">
    <h2 class="trainer-name">
        Payment process will be redirected to these links:
    </h2>
    <div class="full-width">
        <label>Success Payment</label>
        <input type="text" value="{$successUrl}" style="background: lightgrey;" readonly>
    </div>

    <div class="full-width">
        <label>Canceled Payment</label>
        <input type="text" value="{$cancelUrl}" style="background: lightgrey;" readonly>
    </div>
</form>

<hr />

<div class="tecSee-table-parent">
    <div class='tecSee-table-container'>
        <div class="tecSee-remove-padding">
            <table class="tecSee-table">
                <thead>
                    <tr>
                        <th>select</th>
                        <th>id</th>
                        <th>Business account/Business-Konto</th>
                        <th>Client Id/Kunden-ID</th>
                        <th>Secret Key/Geheimcode</th>
                        <th>delete</th>
                    <tr>
                </thead>
                <tbody>
                    <tr>
                        {if (isset($credentials)) && $credentials|@count > 0}
                            {foreach from=$credentials item=credential}
                                <td id="api-credentials-td">
                                    <button class="fas fa-edit text-dark" onclick='handleCredential({$credential})'></button>
                                </td>
                                <td>{$credential->id}</td>
                                <td>{$credential->business_account}</td>
                                <td>{$credential->client_id}</td>
                                <td>{$credential->secret_key}</td>
                                <td>
                                    <form onsubmit="deleteCredentials(event,{$credential->id})" action="" method="get">
                                        <input type="hidden" name="kPlugin" value="{$pluginId}">
                                        <input type="hidden" name="fetch" value="api-credentials">
                                        <input type="hidden" name="_method" value="DELETE">
                                        <input type="hidden" name="credentialId" value="{$credential->id}">
                                        {$jtl_token}
                                        <button type="submit" class="btn btn-danger tecSee-button-delete"
                                            style="font-weight: bold;">Delete</button>
                                    </form>
                                </td>
                            {/foreach}
                        {else}
                            <td class='text-center' id='npApiMessage' colspan="6">there is no data here</td>
                        {/if}
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>



<button type="button" hidden class="btn btn-info btn-lg" id="credentialmodeledit" data-toggle="modal"
    data-target="#credentialModal"></button>

<!--  Edit modal -->

<div class="modal fade" id="credentialModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <i id="close-edit-credentials" class="fas fa-xmark close" data-dismiss="modal">X</i>
                <h4>Edit</h4>
            </div>

            <div class="modal-body">
                <form class="tecSee-form" onsubmit='updateCredentials(event)' id="update-credentials" method="POST"
                    autocomplete="off" enctype="multipart/form-data">
                    {$jtl_token}

                    <input type="hidden" id="credentialId" name="credentialId" value="">

                    <div>
                        <label>Business account/Business-Konto</label>
                        <input type="text" name="business_account" id="businessAccount"
                            placeholder="Write your business account/Schreiben sie ihre Business-Konto" required>
                    </div>

                    <div>
                        <label>Client Id/Kunden-ID</label>
                        <input type="text" name="client_id" id="clientId"
                            placeholder="Write your client id/Schreiben Sie Ihre Kunden-ID" required>
                    </div>

                    <div class="full-width">
                        <label>Secret Key/Geheimcode</label>
                        <input type="text" name="secret_key" id="secretKey"
                            placeholder="Write your secret key/Schreiben Sie Ihren Geheimcode" required>
                    </div>

                    <div>
                        <label for="paypal-mode">Paypal Mode/Paypal-Modus</label>
                        <select name="paypal-mode" id="paypal-mode" required>
                            <option disabled selected value="">Chose Paypal Mode</option>
                            <option value="PAYPAL_LIVE">live Mode</option>
                            <option value="PAYPAL_SAND_BOX">Sand Box Mode</option>
                        </select>
                    </div>

                    <input type="submit" value="Edit">
                </form>
            </div>
        </div>

    </div>
</div>



<!-- Modal -->
<!--  Edit modal -->

<!-- Button trigger modal -->
<button style="display: none;" id="open-credentials-button" type="button" class="btn btn-primary" data-toggle="modal"
    data-target="#modalForCredentialsTab">
</button>

<!-- Modal -->
<div class="modal fade" id="modalForCredentialsTab" tabindex="-1" role="dialog"
    aria-labelledby="modalForCredentialsTabTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                <button id="close-credentials-icon" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="credentials-message"></p>
            </div>
            <div class="modal-footer">
                <button id="close-credentials-button" type="button" class="btn btn-secondary"
                    data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


{include file="./handleCredential.tpl"}