<!-- Button trigger modal -->
<button style="display: none;" id="open-translations-button" type="button" class="btn btn-primary" data-toggle="modal"
    data-target="#modalForTranslations">
</button>

<!-- Modal -->
<div class="modal fade" id="modalForTranslations" tabindex="-1" role="dialog" aria-labelledby="modalForImageTranslationsTitle"
    aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
                <button id="close-translations-icon" type="button" class="close" data-dismiss="modal"
                    aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="translations-message"></p>
            </div>
            <div class="modal-footer">
                <button id="close-translations-button" type="button" class="btn btn-secondary"
                    data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>