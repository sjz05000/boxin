<?php

namespace app\common\model;

use think\Model;

// 明星行程表
class StarProgram extends Base
{
    /**
     * 图片加域名
     */
    public function getBannerAttr($v)
    {
        // 存储方式  第三方存储  本地服务器存储
        if(strpos($v,'uploads') === false){
            return config('app.qiniu.cdnUrl').$v;
        }else{
            return config('app.url').$v;
        }
    }
    
}
