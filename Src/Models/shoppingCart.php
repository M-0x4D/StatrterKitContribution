<?php

namespace MvcCore\Jtl\Models;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class shoppingCart extends Model
{
    use HasFactory;
    protected $table    = 'twarenkorb';

    protected $primaryKey  = 'kWarenkorb';

    protected $fillable = [
        'kWarenkorb', //Shopping cart (int)
        'kKunde', // id for client
        'kLieferadresse',  //Shipping address (int)
        'kZahlungsInfo', // paymentInfo (int)
    ];

}