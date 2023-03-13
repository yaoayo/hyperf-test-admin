<?php

declare (strict_types = 1);

namespace App\Service;
use App\Model\PtConfig;
use App\Utils\Cache;

class CacheConfigService
{
    /**
     * [getKey 过期系统配置]
     * @param  [string] $key    [pt_config表contens字段json key]
     * @param  [string] $prefix [pt_config表name字段]
     * @return [string]         [description]
     */
    public static function getKey($key,$prefix){

        if (!Cache::has($prefix.':'.$key)) {

            $PtConfig = PtConfig::where('name',$prefix)->value('contens');

            if (empty($PtConfig)) return null;

            $contens = json_decode($PtConfig,true);
            
            if (empty($contens)) return null;

            foreach ($contens as $key => $value) {
                Cache::set($prefix.':'.$key,$value);
            }
        }
        return Cache::get($prefix.':'.$key);
    }
}