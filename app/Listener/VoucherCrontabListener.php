<?php

declare(strict_types=1);

namespace App\Listener;

use Hyperf\Crontab\Event\FailToExecute;
use Hyperf\Event\Annotation\Listener;
use Hyperf\Event\Contract\ListenerInterface;
use Psr\Container\ContainerInterface;
use App\Utils\Log;

#[Listener]
class VoucherCrontabListener implements ListenerInterface
{
    public function listen(): array
    {
        return [
            FailToExecute::class,
        ];
    }

    /**
     * @param FailToExecute $event
     */
    public function process(object $event)
    {
        Log::getInstance($event->crontab->getName())->info($event->throwable->getMessage());
    }
}
