<?php

declare (strict_types = 1);

namespace App\Model;

use Hyperf\Database\Model\SoftDeletes;
use Hyperf\DbConnection\Model\Model;

class DicEntry extends Model
{
    use SoftDeletes;

    const DELETED_AT = 'deleted';

    public $timestamps = false;
    protected $table = 'pt_dic_entry';
    protected $primaryKey = 'id';

}
