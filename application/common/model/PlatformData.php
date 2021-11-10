<?php

namespace app\common\model;

use think\Model;

// 平台信息表
class PlatformData extends Base
{
    /**
     * 图片加域名
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
     * 商品头图加域名
     */
    public function getTitleImgAttr($v)
    {
        $arr = json_decode($v);

        // 存储方式  第三方存储  本地服务器存储
        if(strpos($arr[0],'uploads') === false){
            // 文件录入(不加域名), 第三方存储录入(加域名)
            if(strpos($arr[0],'http') === false){ 
                foreach($arr as &$vv)
                {
                    $vv = config('app.qiniu.cdnUrl').$vv;
                }
            }
        }else{
            // 本地服务器录入
            foreach($arr as &$vv)
            {
                $vv = config('app.url').$vv;
            }

        }
        return $arr;
    }

    /**
     * 商品详情图片加域名
     */
    public function getDetailsAttr($v)
    {
        $arr = json_decode($v);

        // 存储方式  第三方存储  本地服务器存储
        if(strpos($arr[0],'uploads') === false){
            // 文件录入(不加域名), 第三方存储录入(加域名)
            if(strpos($arr[0],'http') === false){ 
                foreach($arr as &$vv)
                {
                    $vv = config('app.qiniu.cdnUrl').$vv;
                }
            }
        }else{
            // 本地服务器录入
            foreach($arr as &$vv)
            {
                $vv = config('app.url').$vv;
            }

        }
        return $arr;
    }
}
