{include file="../layout/tecsee_styles.tpl"}

<form onsubmit="addNewObject(event);" id="add-new-object-form" class="tecSee-form" method="POST" method="POST"
    autocomplete="off" enctype="multipart/form-data">
    {$jtl_token}

    <div class="full-width">
        <label for="nameEn">English Name/Englischer Name</label>
        <input id="nameEn" type="text" name="object_name_en"
            placeholder="Type object name english/Typ Objektname englisch" required>
    </div>

    <div class="full-width">
        <label for="nameDe">German Name/Deutscher Name</label>
        <input id="nameDe" type="text" name="object_name_de"
            placeholder="Type object name german/Typ Objektname deutsch" required>
    </div>

    <div class="full-width">
        <label for="price">Price/Preis</label>
        <input id="price" type="number" name="price" placeholder="Type object price/Typ Objektpreis" min="1" required>
    </div>

    <div class="full-width">
        <label for="quantity">quantity/Menge</label>
        <input id="quantity" type="number" name="quantity" placeholder="Type object quantity/Typ Objektmenge" min="1"
            required>

        {* <section class="col-sm pl-sm-3 pr-sm-5 order-last order-sm-2 config-type-number">
            <section class="input-group form-counter">
                <section class="input-group-prepend">
                    <button type="button" class="btn btn-outline-secondary border-0" data-count-down="">
                        <span class="fas fa-minus"></span>
                    </button>
                </section>
                <input type="number" class="form-control" name="nVerwendungen" id="nVerwendungen" value="0">
                <section class="input-group-append">
                    <button type="button" class="btn btn-outline-secondary border-0" data-count-up="">
                        <span class="fas fa-plus"></span>
                    </button>
                </section>
            </section>
        </section> *}
    </div>


    {if (isset($currencies))}
        <div class="full-width">
            <label for="color">currency/Währung</label>
            <select id="color" name="currency_id" required>
                <option value="" selected disabled>Choose Currency</option>
                {foreach from=$currencies item=currency}
                    <option value="{$currency->id}">{$currency->name}</option>
                {/foreach}
            </select>
        </div>
    {/if}

    <div class="full-width">
        <label for="duration">Duration/Dauer</label>
        <select id="duration" name="duration" required>
            <option value="" selected disabled>Choose duration</option>
            <option value="60">Hour/Stunde</option>
            <option value="1">Day/Tag</option>
            <option value="7">Week/Woche</option>
            <option value="30">Month/Monat</option>
        </select>
    </div>

    {if (isset($colors))}
        <div class="full-width">
            <label for="color">Color/Die Farbe</label>
            <select id="color" name="color_id" required>
                <option value="" selected disabled>Choose Color</option>
                {foreach from=$colors item=color}
                    <option value="{$color->id}">{$color->colorNameEN}</option>
                {/foreach}
            </select>
        </div>
    {/if}

    {if (isset($locations))}
        <div class="full-width">
            <label for="location">location/Standort</label>
            <select id="location" name="location_id" required>
                <option value="" selected disabled>Choose Location</option>
                {foreach from=$locations item=location}
                    <option value="{$location->id}">{$location->locationNameEN}</option>
                {/foreach}
            </select>
        </div>
    {/if}

    {if (isset($categories))}
        <div class="full-width">
            <label for="category">category name/Kategoriebezeichnung</label>
            <select id="category" name="category_id" required>
                <option value="" selected disabled>Choose Category</option>
                {foreach from=$categories item=category}
                    <option value="{$category->id}">{$category->categoryNameEN}</option>
                {/foreach}
            </select>
        </div>
    {/if}

    <div class="full-width">
        <label for="long_description_en">Long Description English/lange Beschreibung Englisch</label>
        <textarea required style="resize: none;" id="long_description_en" name="long_description_en"
            rows="4">object long description/Objekt lange Beschreibung</textarea>
    </div>

    <div class="full-width">
        <label for="long_description_de">Long Description German/lange Beschreibung Deutsch</label>
        <textarea required style="resize: none;" id="long_description_de" name="long_description_de"
            rows="4">object long description/Objekt lange Beschreibung</textarea>
    </div>

    <div class="full-width">
        <label for="short_description_en">Short Description English/Kurzbeschreibung Englisch</label>
        <textarea required style="resize: none;" id="short_description_en" name="short_description_en"
            rows="4">object long description/Objekt lange Beschreibung</textarea>
    </div>

    <div class="full-width">
        <label for="short_description_de">Short Description German/Kurzbeschreibung Deutsch</label>
        <textarea required style="resize: none;" id="short_description_de" name="short_description_de"
            rows="4">object description/Objektbeschreibung</textarea>
    </div>

    <div class="full-width">
        <label for="image">Main Image/Hauptbild</label>
        <input id="image" required type="file" name="image" accept="image/png, image/gif, image/jpeg"
            style="width: 100%;" />
    </div>

    <div>
        <label>Price Includes</label>
        <textarea type="text" name="price_includes_en" style="resize: none;"
            placeholder="separarte with comma: first point, second point, third point ... etc" required></textarea>
    </div>

    <div>
        <label>Im Preis inbegriffen</label>
        <textarea type="text" name="price_includes_de" style="resize: none;"
            placeholder="mit Komma trennen: erster Punkt, zweiter Punkt, dritter Punkt ... usw." required></textarea>
    </div>

    <div>
        <label>Price Excludes</label>
        <textarea type="text" name="price_excludes_en" style="resize: none;"
            placeholder="separarte with comma: first point, second point, third point ... etc" required></textarea>
    </div>

    <div>
        <label>Der Preis schließt aus</label>
        <textarea type="text" name="price_excludes_de" style="resize: none;"
            placeholder="mit Komma trennen: erster Punkt, zweiter Punkt, dritter Punkt ... usw." required></textarea>
    </div>

    <hr class="full-width">

    <div id="additional_inputs_controllers" class="full-width" style="padding: 0; margin: 0;">

        <h2 class="text-center">Additional Features/Zusätzliche Merkmale</h2>

        <div>
            <label for="additional-features-name">Features Name</label>
            <input id="additional-features-name" type="text" name="custom_features_input"
                placeholder="Type features name/Typmerkmale Name">
        </div>

        <div>
            <label for="additional-features-type">Features Type/Merkmale Typ</label>
            <select id="additional-features-type" name="custom_features_input">
                <option value="" selected disabled>Choose features type</option>
                <option value="string">text</option>
                <option value="integer">number</option>
                <option value="text">textarea</option>
            </select>
        </div>
    </div>

    <div style="height: fit-content; width: 100%;margin: 10px 0 0;padding: 0;" class="full-width tecSee-table-parent">
        <div style="padding:0; margin:0;" class='tecSee-table-container'>
            <div style="padding:0; margin:0;" class="tecSee-remove-padding">
                <table class="tecSee-table mb-3">
                    <thead>
                        <tr>
                            <th>number</th>
                            <th>name</th>
                            <th>type</th>
                            <th>value</th>
                            <th>delete</th>
                        <tr>
                    </thead>

                    <tbody id="additional_inputs">
                        <tr>
                            <td class="text-center" colspan="5">there is no data</td>
                        <tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <input type="hidden" id="additional-features-array" name="additional_features">

    <hr class="full-width">

    <input type="submit" value="Create">
</form>

<hr />

{* <pre>
    {$objects|print_r}
</pre> *}

<div class="tecSee-table-parent">
    <div class="tecSee-table-container">
        <div class="tecSee-remove-padding mb-3" style="overflow: scroll;">
            <table class="table table-striped table-align-top tecSee-table">
                <thead>
                    <tr>
                        <th class="text-center">Number</th>
                        <th class="text-center">English Name</th>
                        <th class="text-center">German Name</th>
                        <th class="text-center">Price</th>
                        {* <th class="text-center">Quantity</th> *}
                        <th class="text-center">Duration</th>
                        <th class="text-center">Color</th>
                        <th class="text-center">Location</th>
                        <th class="text-center">Category</th>
                        <th class="text-center">Long Description English</th>
                        <th class="text-center">Long Description English</th>
                        <th class="text-center">Short Description German</th>
                        <th class="text-center">Short Description German</th>

                        <th class="text-center">Price Includes</th>
                        <th class="text-center">Im Preis Inbegriffen</th>
                        <th class="text-center">Price Excludes</th>
                        <th class="text-center">Der Preis Schließt Aus</th>
                        <th class="text-center">Main Image</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody id="all-promotions-data">
                    {if $objects|@count > 0}
                        {foreach $objects as $object}
                            <tr class="text-center">
                                <td>{$object@iteration}</td>
                                <td>{$object->objectNameEN}</td>
                                <td>{$object->objectNameDE}</td>
                                <td>{$object->price}</td>
                                {* <td>{$object->quantity}</td> *}
                                <td>{$object->duration}</td>
                                <td>{$object->colorName->en}</td>
                                <td>{$object->location->en}</td>
                                <td>{$object->categoryName->en}</td>
                                <td class="control-height">
                                    <div>{$object->longDescription->en}</div>
                                </td>
                                <td class="control-height">
                                    <div>{$object->longDescription->de}</div>
                                </td>
                                <td class="control-height">
                                    <div>{$object->shortDescription->en}</div>
                                </td>
                                <td class="control-height">
                                    <div>{$object->shortDescription->de}</div>
                                </td>

                                <td class="control-height">
                                    <div>{$object->priceIncludesEN}</div>
                                </td>
                                <td class="control-height">
                                    <div>{$object->priceIncludesDE}</div>
                                </td>
                                <td class="control-height">
                                    <div>{$object->priceExcludesEN}</div>
                                </td>
                                <td class="control-height">
                                    <div>{$object->priceExcludesDE}</div>
                                </td>

                                <td><img src="{$object->image}" alt="picture" width="100px" height="100px"></td>

                                <td class="td-buttons-container">
                                    <div style="display:flex; gap: 10px;">
                                        <button data-object='{$object->id}' class="btn btn-danger w-fit DeleteObject">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>

                                        <button onclick='openObjectUpdateModel({$object});'
                                            class="btn btn-primary w-fit update-oject">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    {else}
                        <tr>
                            <td class='text-center' id='npApiMessage' colspan="18">there is no data here</td>
                        </tr>
                    {/if}
                </tbody>
            </table>
        </div>
    </div>
</div>

{* ======================== popup modal *}
<button type="button" class="d-none" id="add-new-oject" data-toggle="modal"
    data-target="#add-new-object-operations"></button>

<div class="modal fade" id="add-new-object-operations" tabindex="-1" role="dialog"
    aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                <button id="close-add-object-modal" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="add-object-request-messages">

                </p>
            </div>
            <div class="modal-footer">
                <button type="button" id="close-add-new-oject" class="btn btn-secondary"
                    data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
{* ======================== popup modal *}

{* ============================================================== *}

{* ======================== update modal *}
<button type="button" hidden class="btn btn-info btn-lg" id="ojectEditModelButton" data-toggle="modal"
    data-target="#ojectEditModal"></button>

<!--  Edit modal -->
<div class="modal fade" id="ojectEditModal" role="dialog" style="min-width: 50%;width: fit-content;">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <i id="close-promotion-update-modal" class="fas fa-xmark close" data-dismiss="modal">X</i>
                <h4>Edit</h4>
            </div>
            <div class="modal-body">
                <form onsubmit="updateObject(event);" id="update-object-form" class="tecSee-form">
                    {$jtl_token}

                    <div class="full-width">
                        <label for="update-nameEn">English Name/Englischer Name</label>
                        <input id="update-nameEn" type="text" name="object_name_en"
                            placeholder="Type object name english/Typ Objektname englisch" required>
                    </div>

                    <div class="full-width">
                        <label for="update-nameDe">German Name/Deutscher Name</label>
                        <input id="update-nameDe" type="text" name="object_name_de"
                            placeholder="Type object name german/Typ Objektname deutsch" required>
                    </div>

                    <div class="full-width">
                        <label for="update-price">Price/Preis</label>
                        <input id="update-price" type="number" name="price"
                            placeholder="Type object price/Typ Objektpreis" min="0" required>
                    </div>

                    <div class="full-width">
                        <label for="update-quantity">quantity/Menge</label>
                        <input id="update-quantity" type="number" name="quantity"
                            placeholder="Type object quantity/Typ Objektmenge" min="1" required>
                    </div>

                    <div class="full-width">
                        <label for="update-duration-obj">Duration/Dauer</label>
                        <select id="update-duration-obj" name="duration" required>
                            <option value="" selected disabled>Choose duration</option>
                            <option value="60">Hour/Stunde</option>
                            <option value="1">Day/Tag</option>
                            <option value="7">Week/Woche</option>
                            <option value="30">Month/Monat</option>
                        </select>
                    </div>

                    {if (isset($colors))}
                        <div class="full-width">
                            <label for="update-color-obj">Color/Die Farbe</label>
                            <select id="update-color-obj" name="color_id" required>
                                <option value="" selected disabled>Choose Color</option>
                                {foreach from=$colors item=color}
                                    <option value="{$color->id}">{$color->colorNameEN}</option>
                                {/foreach}
                            </select>
                        </div>
                    {/if}

                    {if (isset($locations))}
                        <div class="full-width">
                            <label for="update-location-obj">location/Standort</label>
                            <select id="update-location-obj" name="location_id" required>
                                <option value="" selected disabled>Choose Location</option>
                                {foreach from=$locations item=location}
                                    <option value="{$location->id}">{$location->locationNameEN}</option>
                                {/foreach}
                            </select>
                        </div>
                    {/if}

                    {if (isset($categories))}
                        <div class="full-width">
                            <label for="update-category-obj">category name/Kategoriebezeichnung</label>
                            <select id="update-category-obj" name="category_id" required>
                                <option value="" selected disabled>Choose Category</option>
                                {foreach from=$categories item=category}
                                    <option value="{$category->id}">{$category->categoryNameEN}</option>
                                {/foreach}
                            </select>
                        </div>
                    {/if}

                    <div class="full-width">
                        <label for="update_long_description_en">Long Description English/lange Beschreibung
                            Englisch</label>
                        <textarea required style="resize: none;" id="update_long_description_en"
                            name="long_description_en"
                            rows="4">object long description/Objekt lange Beschreibung</textarea>
                    </div>

                    <div class="full-width">
                        <label for="update_long_description_de">Long Description German/lange Beschreibung
                            Deutsch</label>
                        <textarea required style="resize: none;" id="update_long_description_de"
                            name="long_description_de"
                            rows="4">object long description/Objekt lange Beschreibung</textarea>
                    </div>

                    <div class="full-width">
                        <label for="update_short_description_en">Short Description English/Kurzbeschreibung
                            Englisch</label>
                        <textarea required style="resize: none;" id="update_short_description_en"
                            name="short_description_en"
                            rows="4">object long description/Objekt lange Beschreibung</textarea>
                    </div>

                    <div class="full-width">
                        <label for="update_short_description_de">Short Description German/Kurzbeschreibung
                            Deutsch</label>
                        <textarea required style="resize: none;" id="update_short_description_de"
                            name="short_description_de" rows="4">object description/Objektbeschreibung</textarea>
                    </div>

                    <div class="full-width">
                        <label for="update-image">Main Image/Hauptbild</label>
                        {* <input id="update-image" required type="file" name="image"
                            accept="image/png, image/gif, image/jpeg" style="width: 100%;" /> *}

                        <input id="update-image" required type="file" name="image"
                            accept="image/png, image/gif, image/jpeg" style="width: 100%;" />
                    </div>

                    <div class="full-width">
                        <label for="update_includes_en">Price Includes</label>
                        <textarea id="update_includes_en" type="text" name="price_includes_en" style="resize: none;"
                            placeholder="separarte with comma: first point, second point, third point ... etc"
                            required></textarea>
                    </div>

                    <div class="full-width">
                        <label for="update_includes_de">Im Preis inbegriffen</label>
                        <textarea id="update_includes_de" type="text" name="price_includes_de" style="resize: none;"
                            placeholder="mit Komma trennen: erster Punkt, zweiter Punkt, dritter Punkt ... usw."
                            required></textarea>
                    </div>

                    <div class="full-width">
                        <label for="update_excludes_en">Price Excludes</label>
                        <textarea id="update_excludes_en" type="text" name="price_excludes_en" style="resize: none;"
                            placeholder="separarte with comma: first point, second point, third point ... etc"
                            required></textarea>
                    </div>

                    <div class="full-width">
                        <label for="update_excludes_de">Der Preis schließt aus</label>
                        <textarea id="update_excludes_de" type="text" name="price_excludes_de" style="resize: none;"
                            placeholder="mit Komma trennen: erster Punkt, zweiter Punkt, dritter Punkt ... usw."
                            required></textarea>
                    </div>

                    <hr class="full-width">

                    <div id="update_additional_inputs_controllers" class="full-width" style="padding: 0; margin: 0;">

                        <h2 class="text-center">Additional Features/Zusätzliche Merkmale</h2>

                        <div>
                            <label for="update-additional-features-name">Features Name</label>
                            <input id="update-additional-features-name" type="text" name="update_custom_features_input"
                                placeholder="Type features name/Typmerkmale Name">
                        </div>

                        <div>
                            <label for="update-additional-features-type">Features Type/Merkmale Typ</label>
                            <select id="update-additional-features-type" name="update_custom_features_input">
                                <option value="" selected disabled>Choose features type</option>
                                <option value="string">text</option>
                                <option value="integer">number</option>
                                <option value="text">textarea</option>
                            </select>
                        </div>
                    </div>

                    <div style="height: fit-content; width: 100%;margin: 10px 0 0;padding: 0;"
                        class="full-width tecSee-table-parent">
                        <div style="padding:0; margin:0;" class='tecSee-table-container'>
                            <div style="padding:0; margin:0;" class="tecSee-remove-padding">
                                <table class="tecSee-table mb-3">
                                    <thead>
                                        <tr>
                                            <th>number</th>
                                            <th>name</th>
                                            <th>type</th>
                                            <th>value</th>
                                            <th>delete</th>
                                        <tr>
                                    </thead>

                                    <tbody id="update_additional_inputs">
                                        <tr>
                                            <td class="text-center" colspan="5">there is no data</td>
                                        <tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <input type="hidden" id="update-additional-features-array" name="additional_features">

                    <hr class="full-width">

                    <input type="submit" value="Create">
                </form>
            </div>
        </div>

    </div>
</div>
{* ======================== update modal *}

<script src="{$pluginPath}js/objects/index.js"></script>