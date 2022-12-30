<?php

namespace MvcCore\Jtl\Support\Faker;

class Faker
{
    public FakerImage $fakerImage;
    public FakerString $fakerString;

    public function __construct()
    {
        $this->fakerImage = new FakerImage();
        $this->fakerString = new FakerString();
    }
}
