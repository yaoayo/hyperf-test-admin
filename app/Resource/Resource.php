<?php

namespace App\Resource;

use Hyperf\Resource\Json\JsonResource;

class Resource extends JsonResource
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
            'pid'=>$this->pid,
            'systemId'=>$this->system_id,
            'title'=>$this->title,
            'type'=>$this->type,
            'url'=>$this->url,
            'permissions'=>$this->permissions,
            'icon'=>$this->icon,
            'sortNo'=>$this->sort_no,
            'keepalive'=>$this->keepalive,
            'component'=>$this->component,
            'hidden'=>$this->hidden,
            'remark'=>$this->remark,
            'status'=>$this->status,
            'deleted'=>$this->deleted,
            'creator'=>$this->creator,
            'createTime'=>$this->create_time,
            'updater'=>$this->updater,
            'updateTime'=>$this->update_time,
        ];
    }
}
