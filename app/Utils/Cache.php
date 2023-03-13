<?php
declare(strict_types=1);

namespace App\Utils;

use Hyperf\Utils\ApplicationContext;

class Cache
{
        public static function getInstance()
        {
                return ApplicationContext::getContainer()->get(\Psr\SimpleCache\CacheInterface::class);
        }

        public static function __callStatic($name, $arguments)
        {
                return self::getInstance()->$name(...$arguments);
        }
}