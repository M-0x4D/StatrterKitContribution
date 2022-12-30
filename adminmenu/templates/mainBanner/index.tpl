{include file="../layout/tecsee_styles.tpl"}


<form class="tecSee-form" onsubmit='createBanner(event)' id="create-main-banner">
    {$jtl_token}
    <div class="full-width">
        <label>Banner Image/Bild-Banner</label>
        <input id="uploadCreateBanner" type="file" accept="image/png, image/gif, image/jpeg" name="banner" required>
    </div>

    <input type="submit" value="Create">
</form>

<hr />
{if (isset($banar)) && (count($banar) > 0)}
    <div class="tecSee-table-parent">
        <div class='tecSee-table-container'>
            <div class="tecSee-remove-padding">
                <table class="tecSee-table">
                    <thead>
                        <tr>
                            <th>index</th>
                            <th>Banner Image/Bild-Banner</th>
                            <th>actions</th>
                        <tr>
                    </thead>
                    <tbody>
                        {if $banar|@count > 0}
                            <tr>
                                <td>1</td>
                                <td>
                                    <img src="{$banar.path}" alt="picture" width="100px" height="100px">
                                </td>
                                <td>
                                    <div style="display: flex; gap:10px;">
                                        <button class="btn-primary"
                                            onclick="handleBannerImage({$banar.banarId});">update</button>

                                        <button class="btn-danger"
                                            onclick="deleteBannerImage({$banar.banarId});">delete</button>
                                    </div>
                                </td>
                            </tr>
                        {else}
                            <tr>
                                <td colspan="3">there is no data</td>
                            </tr>
                        {/if}
                    </tbody>
                </table>
            </div>
        </div>
    </div>


{/if}


<button type="button" hidden class="btn btn-info btn-lg" id="bannerEditModalButton" data-toggle="modal"
    data-target="#bannerEditModal"></button>

<!--  Edit modal -->
<div class="modal fade" id="bannerEditModal" role="dialog" style="min-width: 50%;width: fit-content;">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <i id="close-banner-icon" class="fas fa-xmark close" data-dismiss="modal">X</i>
                <h4>Edit</h4>
            </div>

            <div class="modal-body">
                <form class="tecSee-form" onsubmit='updateBanner(event)' id="update-banner">
                    {$jtl_token}

                    <div class="full-width">
                        <label>Banner Image/Bild-Banner</label>
                        <input id="obj-banner-input" accept="image/png, image/gif, image/jpeg" type="file" name="banner"
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
<button style="display: none;" id="open-banner-button" type="button" class="btn btn-primary" data-toggle="modal"
    data-target="#modalForBanner">
</button>

<!-- Modal -->
<div class="modal fade" id="modalForBanner" tabindex="-1" role="dialog" aria-labelledby="modalForImageTabTitle"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                <button id="close-message-banner-icon" type="button" class="close" data-dismiss="modal"
                    aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="banner-message"></p>
            </div>
            <div class="modal-footer">
                <button id="close-banner-button" type="button" class="btn btn-secondary"
                    data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="{$pluginPath}js/mainBanner/index.js"></script>