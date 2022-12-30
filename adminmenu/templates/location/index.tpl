{include file="../layout/tecsee_styles.tpl"}

<form class="tecSee-form" onsubmit='createLocation(event)' id="create-location" method="POST" autocomplete="off"
    enctype="multipart/form-data">
    {$jtl_token}
    <div>
        <label>Location</label>
        <input type="text" name="location_name_en" placeholder="Type the car's location" required>
    </div>

    <div>
        <label>Standort</label>
        <input type="text" name="location_name_de" placeholder="Geben Sie den Standort des Fahrzeugs ein" required>
    </div>

    <input type="submit" value="Create">
</form>

<hr />
{if (isset($locations)) && (count($locations) > 0)}

    <div class="tecSee-table-parent">
        <div class='tecSee-table-container'>
            <div class="tecSee-remove-padding">
                <table class="tecSee-table">
                    <tr>
                        <th>select</th>
                        <th>id</th>
                        <th>Location</th>
                        <th>Standort</th>
                        <th>delete</th>
                    <tr>
                        {foreach from=$locations item=location}
                        <tr>
                            <td>
                                <button class="fas fa-edit text-dark" onclick="handleLocation('{$location->id}',
                                    '{$location->locationNameEN}','{$location->locationNameDE}');">
                                </button>
                            </td>
                            <td>{$location->id}</td>
                            <td>{$location->locationNameEN}</td>
                            <td>{$location->locationNameDE}</td>
                            <td>
                                <form onsubmit="deleteLocation(event,{$location->id})" action="" method="get">
                                    <input type="hidden" name="kPlugin" value="{$pluginId}">
                                    <input type="hidden" name="fetch" value="locations">
                                    <input type="hidden" name="_method" value="DELETE">
                                    <input type="hidden" name="locationId" value="{$location->id}">
                                    {$jtl_token}
                                    <button type="submit" class="btn btn-danger tecSee-button-delete"
                                        style="font-weight: bold;">Delete</button>
                                </form>
                            </td>
                        </tr>
                    {/foreach}
                </table>
            </div>
        </div>
    </div>

{/if}


<button type="button" hidden class="btn btn-info btn-lg" id="locationeditmodal" data-toggle="modal"
    data-target="#locationModal"></button>

<!--  Edit modal -->
<div class="modal fade" id="locationModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <i id="close-edit-location" class="fas fa-xmark close" data-dismiss="modal">X</i>
                <h4>Edit</h4>
            </div>

            <div class="modal-body">
                <form class="tecSee-form" onsubmit='updateLocation(event)' id="update-location" method="POST"
                    autocomplete="off" enctype="multipart/form-data">
                    {$jtl_token}

                    <input type="hidden" id="locationId" name="locationId">
                    <div>
                        <label>Location</label>
                        <input type="text" name="location_name_en" id="location-en"
                            placeholder="Type the car's location" required>
                    </div>

                    <div>
                        <label>Standort</label>
                        <input type="text" name="location_name_de" id="location-de"
                            placeholder="Geben Sie die Farbe des Fahrzeugs ein" required>
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
<button style="display: none;" id="open-location-button" type="button" class="btn btn-primary" data-toggle="modal"
    data-target="#modalForLocationTab">
</button>

<!-- Modal -->
<div class="modal fade" id="modalForLocationTab" tabindex="-1" role="dialog" aria-labelledby="modalForLocationTabTitle"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                <button id="close-location-icon" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="location-message"></p>
            </div>
            <div class="modal-footer">
                <button id="close-location-button" type="button" class="btn btn-secondary"
                    data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

{include file="./locationFooter.tpl"}