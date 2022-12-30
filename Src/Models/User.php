<?php

namespace MvcCore\Jtl\Models;
use Illuminate\Database\Eloquent\Model;
use MvcCore\Jtl\Models\ObjectModel;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class User extends Model
{
    use HasFactory;
    protected $table    = 'tkunde';

    protected $primaryKey  = 'kKunde';

    protected $fillable = [
        'kKundengruppe',
        'kSprache',
        'cKundenNr',
        'cPasswort',
        'cAnrede',
        'cTitel',
        'cVorname',
        'cNachname',
        'cFirma',
    ];

}
