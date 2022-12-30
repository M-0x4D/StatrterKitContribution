<?php

namespace ox4D\cli\Requests;

class CreateRequest
{
    protected static $fileName;

    public static function runCommand($fileName)
    {
        $dir = __DIR__ . '/../../Src/Requests/';
        self::$fileName = $dir.$fileName;
        $myfile = fopen(self::$fileName.".php", "w") or die("Unable to create file!");
        $data = '$'.'data';
        $validator = '$'.'validator';
        $validatedData = '$'.'validatedData';
        $passingInputsThrowValidationRules = 'passingInputsThrowValidationRules';
        $dillarSignThis = '$'.'this';
        $rules = 'rules';
        $txt = "<?php

namespace MvcCore\Jtl\Requests;

use MvcCore\Jtl\Validations\ValidateInputs;
use MvcCore\Jtl\Support\Debug\Debugger;

class $fileName
{
    public function rules()
    {
        return [
            'write rules here!'
        ];
    }

    public function validate(Array $data)
    {
        $validator     = new ValidateInputs($data);
        $validatedData = $validator->$passingInputsThrowValidationRules($dillarSignThis->$rules());
        return $validatedData;
    }
}
        ";
        fwrite($myfile, $txt);
        fclose($myfile);
        echo "[+] $fileName Request File created successfully!\n";
    }
}