{include file="../layout/tecsee_styles.tpl"}


<form class="tecSee-form" onsubmit='createCurrency(event)' id="create-currency">
    {$jtl_token}
    <div>
        <label>Currency</label>
        <input type="text" name="currency_name" placeholder="Type the currency" required>
    </div>

    <div>
        <label>Currency Code</label>
        <input type="text" name="currency_code" placeholder="Type the currency code" required>
    </div>

    <input type="submit" value="Create">
</form>
<hr />

{if (isset($currencies))}
    <div class="tecSee-table-parent">
        <div class='tecSee-table-container'>
            <div class="tecSee-remove-padding">
                <table class="tecSee-table">
                    <thead>
                        <tr>
                            <th>select</th>
                            <th>id</th>
                            <th>currency</th>
                            <th>code</th>
                            <th>delete</th>
                        <tr>
                    </thead>
                    {if $currencies|count > 0}
                        {foreach from=$currencies item=currency}
                            <tr>
                                <td>
                                    <button class="fas fa-edit text-dark"
                                        onclick="handleCurrency('{$currency->id}','{$currency->name}','{$currency->currency_code}');"></button>
                                </td>
                                <td>{$currency->id}</td>
                                <td>{$currency->name}</td>
                                <td>{$currency->currency_code}</td>
                                <td>
                                    <button onclick="deleteCurrency({$currency->id})" type="submit"
                                        class="btn btn-danger tecSee-button-delete" style="font-weight: bold;">Delete</button>
                                </td>
                            </tr>
                        {/foreach}
                    {else}
                        <tr>
                            <td colspan="5" class="text-center">
                                there is no data
                            </td>
                        </tr>
                    {/if}
                </table>
            </div>
        </div>
    </div>
{/if}


<button type="button" hidden class="btn btn-info btn-lg" id="currencyeditmodal" data-toggle="modal"
    data-target="#currencyModal"></button>

<!--  Edit modal -->

<div class="modal fade" id="currencyModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <i id="close-edit-currency" class="fas fa-xmark close" data-dismiss="modal">X</i>
                <h4>Edit</h4>
            </div>

            <div class="modal-body">
                <form class="tecSee-form" onsubmit='updateCurrency(event)' id="update-currency">
                    {$jtl_token}

                    <input type="hidden" id="currencyId" name="currency_id">
                    <div>
                        <label>Currency</label>
                        <input type="text" id="currency-en" name="currency_name" placeholder="Type the currency"
                            required>
                    </div>

                    <div>
                        <label>Currency code</label>
                        <input type="text" id="currency-code" name="currency_code" placeholder="Type the currency code"
                            required>
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
<button style="display: none;" id="open-currency-button" type="button" class="btn btn-primary" data-toggle="modal"
    data-target="#modalForCurrencyTab">
</button>

<!-- Modal -->
<div class="modal fade" id="modalForCurrencyTab" tabindex="-1" role="dialog" aria-labelledby="modalForCurrencyTabTitle"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                <button id="close-currency-icon" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="currency-message"></p>
            </div>
            <div class="modal-footer">
                <button id="close-currency-button" type="button" class="btn btn-secondary"
                    data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="{$pluginPath}js/currency/index.js"></script>