<?php

declare (strict_types = 1);

namespace App\Model;

use Hyperf\Database\Model\SoftDeletes;
use Hyperf\DbConnection\Model\Model;

class Role extends Model
{
    use SoftDeletes;

    const CREATED_AT = 'create_time';
    const UPDATED_AT = 'update_time';
    const DELETED_AT = 'deleted';

    public $timestamps = false;
    protected $table = 'pt_role';
    protected $primaryKey = 'id';

    /*多对多建立关系*/
    public function resource()
    {
        return $this->belongsToMany(Resource::class, 'pt_role_res', 'role_id', 'res_id');
    }
}
