<?php

namespace app\common\model;

use think\Model;

// 经纪公司表
class BrokerageAgency extends Base
{
    /**
     * 平台json转数组
     */
    public function getOtherAttr($v)
    {
        return json_decode($v, true);
    }
    public function getOtherLogoAttr($v)
    {
        // 存储方式  第三方存储  本地服务器存储
        if(strpos($v,'uploads') === false){
            return config('app.qiniu.cdnUrl').$v;
        }else{
            return config('app.url').$v;
        }
    }

    /**
     * 公告json转数组
     */
    public function getNoticeAttr($v)
    {
        return json_decode($v, true);
    }

    /**
     * 加域名
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
}
