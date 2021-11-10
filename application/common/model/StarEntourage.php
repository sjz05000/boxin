<?php

namespace app\common\model;

use think\Model;

// 艺人随从
class StarEntourage extends Base
{
    /**
     * 图片加域名
     */
    public function getHeadAttr($v)
    {
        // 存储方式  第三方存储  本地服务器存储
        if(strpos($v,'uploads') === false){
            return config('app.qiniu.cdnUrl').$v;
        }else{
            return config('app.url').$v;
        }
    }

    /**
     * 职位
     */
    public function getJobAttr($v)
    {
        $arr = [1=>'艺人经纪人', 2=>'艺人助理', 3=>'艺人造型师', 4=>'艺人文宣'];
        return $arr[$v];
    }
}
