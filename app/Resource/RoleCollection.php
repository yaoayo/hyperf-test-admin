<?php

namespace App\Resource;

use Hyperf\Resource\Json\ResourceCollection;

class RoleCollection extends ResourceCollection
{


    /**
     * Transform the resource collection into an array.
     *
     * @return array
     */
    public function toArray(): array
    {
        $resource = [];
        foreach ($this->collection as $key => $role) {
            array_push($resource, Resource::collection($role->resource->resource));
        }
        $res = [];
        foreach ($resource as $data) {
            foreach ($data as $value) {
                $res[] = $value;
            }
        }
        return $res;
    }
}
