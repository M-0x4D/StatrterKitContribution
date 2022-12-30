<?php

namespace MvcCore\Jtl\Validations;

use MvcCore\Jtl\Support\Facades\Localization\Lang;
use MvcCore\Jtl\Helpers\Response;
use MvcCore\Jtl\Support\Debug\Debugger;
use MvcCore\Jtl\Support\Http\Request;

class ValidateInputs extends Request
{

    public function passingInputsThrowValidationRules($rules)
    {
        $inputs = $this->all();
        array_walk($inputs, function (&$input, $key) use ($rules) {
            if (array_key_exists($key, $rules) !== false) {
                switch ($rules[$key]) {
                    case 'required':
                        if ($input) {
                            $input = $input;
                        } else {
                            Alerts::show('warning', ValidationMessage::get('required'), $key);
                        }
                        break;
                    case 'nullable':
                        $input = !!$input ? $input : '';
                        break;
                    default:
                        $input = 'not supported validation rule';
                        break;
                }
            }
        });
        if (isset($inputs['jtl_token']) && !empty($inputs['jtl_token'])) {
            unset($inputs['jtl_token']);
        }
        return $inputs;
    }

    public function passingAjaxRequestThrowValidationRules($rules)
    {
        $inputs = $this->all();
        array_walk($inputs, function (&$input, $key) use ($rules) {
            if (array_key_exists($key, $rules) !== false) {
                switch ($rules[$key]) {
                    case 'required':
                        if ($input) {
                            $input = $input;
                        } else {
                            return Response::json([
                                $key => Lang::get('validations', 'required')
                            ], 422);
                            exit();
                        }
                        break;
                    case 'nullable':
                        $input = !!$input ? $input : '';
                        break;
                    default:
                        $input = 'not supported validation rule';
                        break;
                }
            }
        });
        return $inputs;
    }
}
