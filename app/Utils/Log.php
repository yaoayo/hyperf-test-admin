<?php

declare(strict_types=1);

namespace App\Utils;


use Hyperf\Logger\LoggerFactory;
use Hyperf\Utils\ApplicationContext;

class Log
{
        public static function getInstance(string $name = 'app', string $group = 'default')
        {
                return ApplicationContext::getContainer()->get(LoggerFactory::class)->get($name,$group);
        }

        public static function __callStatic($name, $arguments)
        {
                return self::getInstance()->$name(...$arguments);
        }
}