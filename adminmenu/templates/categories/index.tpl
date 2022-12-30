{include file="../layout/tecsee_styles.tpl"}
<script src="{$pluginPath}js/Fiberjs/Fiber.js" type="text/javascript"></script>
<script src="{$pluginPath}js/Fiberjs/JsonParseException.js" type="text/javascript"></script>
<script src="{$pluginPath}js/Fiberjs/ResponseException.js" type="text/javascript"></script>

<form class="tecSee-form" onsubmit='createCategory(event)' id="create-category" method="POST" autocomplete="off"
    enctype="multipart/form-data">
    {$jtl_token}
    <div>
        <label>Categories</label>
        <input type="text" name="categories_name_en" placeholder="Type the car's categories" required>
    </div>

    <div>
        <label>Kategorien</label>
        <input type="text" name="categories_name_de" placeholder="Geben Sie die Kategorien des Fahrzeugs ein" required>
    </div>

    <input type="submit" value="Create">
</form>
<hr />
{if (isset($categories)) && (count($categories) > 0)}

    <div class="tecSee-table-parent">
        <div class='tecSee-table-container'>
            <div class="tecSee-remove-padding">
                <table class="tecSee-table">
                    <tr>
                        <th>select</th>
                        <th>id</th>
                        <th>categorie</th>
                        <th>kategorie</th>
                        <th>delete</th>
                    <tr>
                        {foreach from=$categories item=category}
                        <tr>
                            <td>
                                <button class="fas fa-edit text-dark"
                                    onclick="handleCategory('{$category->id}','{$category->categoryNameEN}','{$category->categoryNameDE}');"></button>
                            </td>
                            <td>{$category->id}</td>
                            <td>{$category->categoryNameEN}</td>
                            <td>{$category->categoryNameDE}</td>
                            <td>
                                <form onsubmit="deleteCategory(event,{$category->id})" action="" method="get">
                                    <input type="hidden" name="kPlugin" value="{$pluginId}">
                                    <input type="hidden" name="fetch" value="categories">
                                    <input type="hidden" name="_method" value="DELETE">
                                    <input type="hidden" name="categoryId" value="{$category->id}">
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


<button type="button" hidden class="btn btn-info btn-lg" id="categoryeditmodal" data-toggle="modal"
    data-target="#categoryModal"></button>

<!--  Edit modal -->

<div class="modal fade" id="categoryModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <i id="close-edit-category" class="fas fa-xmark close" data-dismiss="modal">X</i>
                <h4>Edit</h4>
            </div>

            <div class="modal-body">
                <form class="tecSee-form" onsubmit='updateCategory(event)' id="update-category" method="POST"
                    autocomplete="off" enctype="multipart/form-data">
                    {$jtl_token}

                    <input type="hidden" id="categoryId" name="categoryId">
                    <div>
                        <label>category</label>
                        <input type="text" id="category-en" name="category_name_en"
                            placeholder="Type the car's category" required>
                    </div>

                    <div>
                        <label>Kategorie</label>
                        <input type="text" name="category_name_de" id="category-de"
                            placeholder="Geben Sie die Kategorie des Fahrzeugs ein" required>
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
<button style="display: none;" id="open-category-button" type="button" class="btn btn-primary" data-toggle="modal"
    data-target="#modalForCategoryTab">
</button>

<!-- Modal -->
<div class="modal fade" id="modalForCategoryTab" tabindex="-1" role="dialog" aria-labelledby="modalForCategoryTabTitle"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Edit Category</h5>
                <button id="close-category-icon" type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="category-message"></p>
            </div>
            <div class="modal-footer">
                <button id="close-category-button" type="button" class="btn btn-secondary"
                    data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="{$pluginPath}js/categories/index.js" type="text/javascript"></script>