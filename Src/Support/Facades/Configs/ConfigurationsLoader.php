<?php

namespace MvcCore\Jtl\Support\Facades\Configs;

use MvcCore\Jtl\Support\Facades\Filesystem\DirectoryComposer;

class ConfigurationsLoader
{
    private array $configs = [];

    public function __construct()
    {
        $directoryComposer = new DirectoryComposer();
        $lines  = file("{$directoryComposer->plugin_root()}/.env");
        $keys   = [];
        $values = [];
        foreach ($lines as $line) {
            $line = trim($line);
            if (!$line) {
                continue;
            }
            if ($line === PHP_EOL || stripos($line, '#') === 0) {
                continue;
            }
            if (stripos($line, PHP_EOL)) {
                [$line,] = explode(PHP_EOL, $line);
            }
            [$keys[], $values[]] = explode('=', $line);
        }
        $this->configs = array_combine($keys, $values);
    }

    public function get(string $key): ?string
    {
        return key_exists($key, $this->configs) ? (string) $this->configs[$key] : null;
    }
}
