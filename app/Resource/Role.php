<?php

namespace App\Resource;

use Hyperf\Resource\Json\JsonResource;

class Role extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array
     */
    public function toArray(): array
    {
        return [
            'id'=>$this->id,
            'title'=>$this->title,
            'code'=>$this->code,
            'remark'=>$this->remark,
            'deleted'=>$this->deleted,
            'creator'=>$this->creator,
            'createTime'=>$this->create_time,
            'updater'=>$this->updater,
            'updateTime'=>$this->update_time
        ];
    }
}
