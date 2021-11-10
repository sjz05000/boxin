<?php

namespace app\common\model;

use think\Model;

// 用户二维码
class UserQrcode extends Base
{
    public function getImgAttr($v)
    {
        return config('app.url').$v;
    }
}
