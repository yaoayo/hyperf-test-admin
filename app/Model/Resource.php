<?php

declare (strict_types = 1);

namespace App\Model;

use Hyperf\Database\Model\SoftDeletes;
use Hyperf\DbConnection\Model\Model;

class Resource extends Model
{
    use SoftDeletes;
    const CREATED_AT = 'create_time';
    const UPDATED_AT = 'update_time';
    const DELETED_AT = 'deleted';

    public $timestamps = false;

    protected $table = 'pt_resource';

    protected $primaryKey = 'id';

    protected $casts = [
        'id' => 'integer',
        'pid' => 'integer',
        'system_id' => 'integer',
        'type' => 'integer',
        'sort_no' => 'integer',
        'keepalive' => 'integer',
        'hidden' => 'integer',
        'status' => 'integer',
    ];

    public function children()
    {
        return $this->hasMany(Resource::class, 'pid', 'id');
    }
}
