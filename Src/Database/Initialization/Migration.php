<?php

namespace MvcCore\Jtl\Database\Initialization;

class Migration
{
    public function call(array $tables, string $type)
    {
        foreach ($tables as $table) {
            $table = new $table();
            if ($type === 'up') {
                $table->up();
            } else if ($type === 'down') {
                $table->down();
            }
        }
    }
    public function callExtention(array $tables, string $type)
    {
        foreach ($tables as $table) {
            $table = new $table();
            if ($type === 'upExtention') {
                $table->up();
            } else if ($type === 'downExtention') {
                $table->down();
            }
        }
    }
}
