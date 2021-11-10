<?php

namespace app\common\model;

use think\Model;

// 商家表
class Business extends Base
{
    /**
     * 店铺logo加域名
     */
    public function getLogoAttr($v)
    {
        // 存储方式  第三方存储  本地服务器存储
        if(strpos($v,'uploads') === false){
            return config('app.qiniu.cdnUrl').$v;
        }else{
            return config('app.url').$v;
        }
    }

    /**
     * 售后电话
     */
    public function getAfterPhoneAttr($v)
    {
        return json_decode($v);
    }
}
