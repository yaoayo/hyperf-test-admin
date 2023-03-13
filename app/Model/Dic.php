<?php

declare (strict_types = 1);

namespace App\Model;

use Hyperf\Database\Model\SoftDeletes;
use Hyperf\DbConnection\Model\Model;

class Dic extends Model
{
    use SoftDeletes;

    const DELETED_AT = 'deleted';

    public $timestamps = false;
    protected $table = 'pt_dic';
    protected $primaryKey = 'id';

}
