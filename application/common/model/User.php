<?php

namespace app\common\model;

use think\Model;

// 用户表
class User extends Base
{
    /**
     * 头像加域名
     */
    public function getHeadAttr($v)
    {
        if($v == 'storage/moren.jpg'){
            $img = config('app.url').$v;
        }else{
            
            // 存储方式  第三方存储  本地服务器存储
            if(strpos($v,'uploads') === false){
                $img = config('app.qiniu.cdnUrl').$v;
            }else{
                $img = config('app.url').$v;
            }

        }
        return $img;
    }
}
