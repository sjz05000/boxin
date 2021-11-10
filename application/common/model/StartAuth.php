<?php

namespace app\common\model;

use think\Model;

// 明星认证(明星认证分两种, 1种平台认证就是当前这个,  第二种是加入经纪公司就算认证了)
class StartAuth extends Base
{
    protected $table = 's_z_start_auth';
}
