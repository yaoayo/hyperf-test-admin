<?php

namespace App\Resource;

use Hyperf\Resource\Json\JsonResource;

class User extends JsonResource
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
            'username'=>$this->username,
            'realName'=>$this->real_name,
            'headerUrl'=>$this->header_url,
            'gender'=>$this->gender,
            'email'=>$this->email,
            'mobile'=>$this->mobile,
            'superAdmin'=>$this->super_admin,
            'remark'=>$this->remark,
            'status'=>$this->status,
            'creator'=>$this->creator,
            'createTime'=>$this->create_time,
            'updater'=>$this->updater,
            'updateTime'=>$this->update_time,
            'roles'=> Role::collection($this->roles),
            'menus'=> new RoleCollection($this->menus),

        ];
    }
}