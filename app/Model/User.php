<?php

declare (strict_types = 1);

namespace App\Model;

use HyperfExt\Auth\Authenticatable;
use HyperfExt\Auth\Contracts\AuthenticatableInterface;
use HyperfExt\Jwt\Contracts\JwtSubjectInterface;
use Hyperf\Database\Model\SoftDeletes;
use Hyperf\DbConnection\Model\Model;

class User extends Model implements JwtSubjectInterface, AuthenticatableInterface
{

    use SoftDeletes;

    const DELETED_AT = 'deleted';
    const CREATED_AT = 'create_time';
    const UPDATED_AT = 'update_time';

    protected $table = 'pt_user';
    protected $primaryKey = 'id';

    // 增加 auth 支持
    use Authenticatable;

    // 增加 jwt接口需要的方法
    public function getJwtCustomClaims(): array
    {
        return [
            // 添加自定义信息
            'guard' => 'api',
        ];
    }

    public function getJwtIdentifier()
    {
        return $this->getKey();
    }

    /*多对多建立关系*/
    public function roles()
    {
        return $this->belongsToMany(Role::class, 'pt_user_role', 'user_id', 'role_id');
    }

    public function menus()
    {
        return $this->belongsToMany(Role::class, 'pt_user_role', 'user_id', 'role_id')->with('resource');
    }
}
